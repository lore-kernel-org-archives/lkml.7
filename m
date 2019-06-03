Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE11CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CEB25B28
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559567946;
	bh=aXYplNsQyPIIU3iosXdops52mTbvO5TWj1ZH0e2m5y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQNsRHuaSqE3NSxEn4gMTbpF1U7hO5nVT8sWaKLQN+y6ZLwKSGVJUrmOP7iSAzgV5
	 46WpmzcM0yHn0jRnuuCoNf6qFxqw+XKsNPPoA2+3CX823Rv6L4jd+oRmsRNfZnGicn
	 psUO01EKaJqibwKbQVeV9VnuHpfL1NmC9qbQI7GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfFCNTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfFCNTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:19:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 948FB25162;
        Mon,  3 Jun 2019 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559567944;
        bh=aXYplNsQyPIIU3iosXdops52mTbvO5TWj1ZH0e2m5y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKyo6M2XLijHBSpowPCGIa52e50oIDHg5UeXTQK8/A5zpiDZgdgHr6O9spi+oGfM6
         UzDmJzm4PH+evWpGO0R/juuUCACjkHgWRvdVP8RvqHrpsTN2m18HmT9OzLT3TXidJ0
         JPVbT1eNdKxVsUTu5846R4uUF014XBU7gbiTMlww=
Date:   Mon, 3 Jun 2019 15:19:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Subject: Re: [PATCH v6 07/10] usb: roles: Add fwnode_usb_role_switch_get()
 function
Message-ID: <20190603131901.GB10397@kroah.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
 <1559115828-19146-8-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559115828-19146-8-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:43:45PM +0800, Chunfeng Yun wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> The fwnode_usb_role_switch_get() function is exactly the
> same as usb_role_switch_get(), except that it takes struct
> fwnode_handle as parameter instead of struct device.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> v6:
>   new patch

If you are forwarding on a patch from someone else, like this, you need
to put your signed-off-by line on it as well.

Please fix that up, and add the tested-by one, when you resend this
series.

thanks,

greg k-h
