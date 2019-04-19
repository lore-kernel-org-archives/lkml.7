Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E6C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D51204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfDSSgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfDSSgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:36:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97FCB30832C2;
        Fri, 19 Apr 2019 11:29:05 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-120-68.rdu2.redhat.com [10.10.120.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9738F5D9C5;
        Fri, 19 Apr 2019 11:29:04 +0000 (UTC)
Date:   Fri, 19 Apr 2019 07:29:02 -0400
From:   Neil Horman <nhorman@redhat.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, linuxarm@huawei.com,
        Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>
Subject: Re: [PATCH net-next 10/12] net: hns3: Add handling of MAC tunnel
 interruption
Message-ID: <20190419112902.GA31368@hmswarspite.think-freely.org>
References: <1555643147-52407-1-git-send-email-tanhuazhong@huawei.com>
 <1555643147-52407-11-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555643147-52407-11-git-send-email-tanhuazhong@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 19 Apr 2019 11:29:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 11:05:45AM +0800, Huazhong Tan wrote:
> From: Weihang Li <liweihang@hisilicon.com>
> 
> MAC tnl interruptions are different from other type of RAS and MSI-X
> errors, because some bits, such as OVF/LR/RF will occur during link up
> and down.
> 
> The drivers should clear status of all MAC tnl interruption bits but
> shouldn't print any message that would mislead the users.
> 
> In case that link down and re-up in a short time because of some reasons,
> we record when they occurred, and users can query them by debugfs.
> 
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> ---
><snip>>
>  					     bool en)
>  {
> @@ -1611,6 +1636,7 @@ pci_ers_result_t hclge_handle_hw_ras_error(struct hnae3_ae_dev *ae_dev)
>  int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
>  			       unsigned long *reset_requests)
>  {
> +	struct hclge_mac_tnl_stats mac_tnl_stats;
>  	struct device *dev = &hdev->pdev->dev;
>  	u32 mpf_bd_num, pf_bd_num, bd_num;
>  	enum hnae3_reset_type reset_level;
> @@ -1745,6 +1771,31 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
>  		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
>  	}
>  
> +	/* query and clear mac tnl interruptions */
> +	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_QUERY_MAC_TNL_INT,
> +				   true);
> +	ret = hclge_cmd_send(&hdev->hw, &desc[0], 1);
Is this running in interrupt context ever?  I don't think it is, but the
function name makes me think otherwise.  If it is, this could be unsafe as you
take a spinlock in hclge_cmd_send, which is protected against bottom halves, but
not interrupts.  That could cause a deadlock if there is a path to get here
directly from an interrupt context.
Neil

