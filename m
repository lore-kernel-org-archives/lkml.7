Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4DC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D1A2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8s5bxx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfJKJ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:27:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45119 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfJKJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:27:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so11029912wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dLVl3DsGhkxOyBDwhPCeN0ImQMXW3n75XQjG9mYAy/o=;
        b=t8s5bxx7C+fKPIIBPy949vMQclzBJ+lBKteDR4GyXhkirQvH5DZIeVDG9zdkq19UIj
         ge/gUM99tjtSovZSaFz1fPJBkubQkbXlg6Uh/bo3FTQpV3CIULT4EByCiGdNmK3/3Ysb
         /rDdqb8G5kinD39QAALmikeVvfBzJ0D4C/cIpzyY/jvtsu05VpUUYVFV8UqjiAeFjDHo
         +2mJzPoENqtE6XcC6LEcO0WFFs68/QioX7eQevfQQ11W5e2TfFzkSr8KJZyrwMedKhGv
         Ek4dE4/4lOlR4NiAEGmiB5RmFZ1ihMYUdlZ7fx/gzBJ5/fOqFSjrgRp4NXWW2+hGMLiU
         cUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dLVl3DsGhkxOyBDwhPCeN0ImQMXW3n75XQjG9mYAy/o=;
        b=bowIZMbXcodrI96a75QVlgYsT9mSwDU0VJd4Xs67wZJwazxajCqpDXrt5Qox/YuJi+
         3puoE9hY+B59xVRuVXNCZaOyMu6r9cvfy9Vg3erP+Dy3aBun2ZouRJ3ZiedD59jlBcE9
         PtcXR5hnIB5jBMcAYwcATyBqUEnfqziL+dQWHgtgX857QY4wc+FcRyVp3IG1glFo6GaX
         /0DfR9UFam+9SxOUIJMHWm17GS/M3tovONp9FC3c7XWEwn7rDYxmOzui6FWjEl+t7uPa
         yy1KwyJxpf29j/zKwo5vT8YWLGviKzIzyNixfOzee17WNvP7lLl0GTQjifYZdX1t8QNw
         ufKQ==
X-Gm-Message-State: APjAAAVk5DJyQC6OCwfI73zM1Imug1Ql+krZwJ1X49XcXLo/QMgYBHmc
        WTzMOdbbZkxHl38/2ni0ppk=
X-Google-Smtp-Source: APXvYqzX3dd/RoeyFYvYk+GNyWdHr5uGU99lkXoKfWbntpFWSTl5Y+aqSM1VIJmypj0Ou8DxbmOiLA==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr11450759wrs.224.1570786018961;
        Fri, 11 Oct 2019 02:26:58 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id 36sm12179547wrp.30.2019.10.11.02.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 02:26:58 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:26:52 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/5] staging: octeon: remove typedef declaration for
 cvmx_helper_link_info_t
Message-ID: <20191011092652.GB10328@wambui>
Reply-To: 20191011090213.GB1076760@kroah.com
References: <cover.1570773209.git.wambui.karugax@gmail.com>
 <78e2c3a4089261e416e9b890cdf81ef029966b75.1570773209.git.wambui.karugax@gmail.com>
 <20191011090213.GB1076760@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011090213.GB1076760@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:02:13AM +0200, Greg KH wrote:
> On Fri, Oct 11, 2019 at 09:02:39AM +0300, Wambui Karuga wrote:
> > -typedef union {
> > +union cvmx_helper_link_info_t {
> 
> I agree with Julia, all of the "_t" needs to be dropped as that is
> pointless.  It's a holdover from the original name where "_t" was trying
> to say that this is a typedef.  Gotta love abuse of hungarian notation
> :(
> 
> Please redo this patch series and resend.
> 
Great, I'll send an updated patch.
Thanks,
Wambui
