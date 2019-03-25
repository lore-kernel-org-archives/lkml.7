Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE97C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA602087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfCYLtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:49:51 -0400
Received: from ns.iliad.fr ([212.27.33.1]:49834 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730917AbfCYLtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:49:50 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 4ED0D208D5;
        Mon, 25 Mar 2019 12:49:48 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 35392207E5;
        Mon, 25 Mar 2019 12:49:48 +0100 (CET)
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_qca: Added support for WCN3998
To:     Harish Bandi <c-hbandi@codeaurora.org>
References: <1553513491-25763-1-git-send-email-c-hbandi@codeaurora.org>
 <1553513491-25763-2-git-send-email-c-hbandi@codeaurora.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <e17eb2d2-8d32-70c6-32f9-435671233bfc@free.fr>
Date:   Mon, 25 Mar 2019 12:49:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553513491-25763-2-git-send-email-c-hbandi@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Mar 25 12:49:48 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 12:31, Harish Bandi wrote:

> +bool is_qca_soc_type_wcn399x_family(enum qca_btsoc_type soc_type)
> +{
> +	if ((soc_type  == QCA_WCN3990) || (soc_type  == QCA_WCN3998))
                      ^                             ^
            spurious white-space               here as well

> +		return true;
> +
> +	return false;
> +}

(Apologies for the bike-shed)

I don't know what the kernel coding-style says about this, but for
functions returning bool, isn't it better to write

	return $BOOLEAN_EXPRESSION;

instead of

	if ($BOOLEAN_EXPRESSION)
		return true;
	return false;

i.e.

bool is_qca_soc_type_wcn399x_family(enum qca_btsoc_type soc_type)
{
	return soc_type == QCA_WCN3990 || soc_type  == QCA_WCN3998;
}

Regards.
