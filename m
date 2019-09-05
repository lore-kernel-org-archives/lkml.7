Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD193C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017E2206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567716921;
	bh=ntuEjX5JizW6A6Ru68KbHjpXRKIWLYw5JmPTgqG9iB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cNo17jJgwoZZuMYVCQp+TCajEO8g/orlFXGZ3x2xfZkK7Nv9IKuWBi9Pw4uHeEYDE
	 cOtq1r/6Stgx8Qeab+WYzpfh5VazaeHCKKLHKcRXHbHBP4UgpdklPoc/EAOmMND5My
	 7KiLpODjqqSJBJs1ndFr2TC5wzejQbo/C7GCi+Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbfIEUzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfIEUzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:55:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81A6206BB;
        Thu,  5 Sep 2019 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567716919;
        bh=ntuEjX5JizW6A6Ru68KbHjpXRKIWLYw5JmPTgqG9iB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYOTFcdmwIO6YdTjUmmXwVPORJ4yUIoKzriixWeb18y5vL3vhVgbIH9BYgFtc3U/W
         O76cVQqUNQs309Qw889OMropdvnaQOVmfjG4lkGMgfu8IrCiFNLLWdFqprgzCks3gr
         VSPf3M9VTVouu6k3WQs1zXlBrxKjVH49JapDmuk8=
Date:   Thu, 5 Sep 2019 22:55:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jacky.Cao@sony.com
Cc:     balbi@kernel.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kento.A.Kobayashi@sony.com
Subject: Re: [PATCH v3] USB: dummy-hcd: fix power budget for SuperSpeed mode
Message-ID: <20190905205516.GA25749@kroah.com>
References: <16EA1F625E922C43B00B9D82250220500871CDE5@APYOKXMS108.ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16EA1F625E922C43B00B9D82250220500871CDE5@APYOKXMS108.ap.sony.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:11:57AM +0000, Jacky.Cao@sony.com wrote:
> The power budget for SuperSpeed mode should be 900 mA
> according to USB specification, so set the power budget
> to 900mA for dummy_start_ss which is only used for
> SuperSpeed mode.
> 
> If the max power consumption of SuperSpeed device is
> larger than 500 mA, insufficient available bus power
> error happens in usb_choose_configuration function
> when the device connects to dummy hcd.
> 
> Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>

Does this "fix" a specific commit in the tree, and if so, what is the
commit id of that?  Also, should this go to the stable kernel(s)?

thanks,

greg k-h
