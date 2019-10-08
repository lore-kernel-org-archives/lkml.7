Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C102EC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DBB2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570549430;
	bh=W4qbPuJMKTMXYc7ExZx/Lic/BRAYA1i782fPAsu3PKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rgUshbPK7HcrX2tXRp0HHsqFhuBDKKG8uz7/k3L35PsnvBEmHyDF/Da7urIP359FI
	 00cfXQWdaCxHuBsXcwKo2gw3DE3Zo0g4SDNtKJuAyxNb6e80sPb90DhH1PAvAshpED
	 npv9U9xiLiHJhJ2fvCA+4NHiUEN4nIG8+0hCKpoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfJHPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfJHPnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:43:49 -0400
Received: from localhost (unknown [89.205.136.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E9C7217D7;
        Tue,  8 Oct 2019 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570549429;
        bh=W4qbPuJMKTMXYc7ExZx/Lic/BRAYA1i782fPAsu3PKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yc/q6+HFFtbovKZs1x6TdjAqSShe6t8mYq2/4+Utc1BHUg5OQHv5Pi4SpOpDRcBiR
         pQQXuuSbvsaLkVPrf4CPQQPXw7r8tzr0gjCq+mFAWXtXIkBCSRKnNfhfwlxNICD9Uj
         ubgo0KcbFLZkszDZEMNYIH1y8dOqrzXwIta4+mew=
Date:   Tue, 8 Oct 2019 17:43:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Murali Nalajala <mnalajal@codeaurora.org>, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v2] base: soc: Handle custom soc information sysfs entries
Message-ID: <20191008154346.GA2881455@kroah.com>
References: <1570480662-25252-1-git-send-email-mnalajal@codeaurora.org>
 <5d9cac38.1c69fb81.682ec.053a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9cac38.1c69fb81.682ec.053a@mx.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:33:11AM -0700, Stephen Boyd wrote:
> Quoting Murali Nalajala (2019-10-07 13:37:42)
> > Soc framework exposed sysfs entries are not sufficient for some
> > of the h/w platforms. Currently there is no interface where soc
> > drivers can expose further information about their SoCs via soc
> > framework. This change address this limitation where clients can
> > pass their custom entries as attribute group and soc framework
> > would expose them as sysfs properties.
> > 
> > Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 

Nice, can we convert the existing soc drivers to use this interface
instead of the "export the device pointer" mess that they currently
have?  That way we can drop that function entirely.

thanks,

greg k-h
