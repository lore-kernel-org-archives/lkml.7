Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53035CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264302084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fkuGCaMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390426AbfJWIjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:39:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36316 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfJWIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:39:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so9640240wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Ht+Dq3YAPtcP/5kWk8fJeCAjPfIj2CPqz7fkwrNtNc=;
        b=fkuGCaMMMuULzBZ+Q+nhwpzDlsIUndph+HQQvswuirV6/v5SP4LPa3Q0x9aBxlsnwp
         9Mp2VFnKxpjQ7hXEdOc8c/lSjEo0Vv3vXc0PEnkvUfXDpUdCAoCElgWGz8Y1NM8OT8Jf
         b05I+QoF+rbfakQZUTUFesf8MBnTIUtgh4NjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2Ht+Dq3YAPtcP/5kWk8fJeCAjPfIj2CPqz7fkwrNtNc=;
        b=BPGSCE6+5XarZ3saXxdbzbn0e4P6ua/DQbEdBisQlbsXIsnx3KQIlEaxWIfNFvPLO8
         tQnYuQKypTNMG8FQhdeDbqv1dTRFlFYueRpGt4AoZot+1+ARLv1fkZgt0M/52u8Np36O
         /ojtAY4G7Cpada2NHusUtwETBLSFhpnX2QIA4SpPx6Dr/2ZQcx+x8yPjhvgZktFtfOAr
         ttKi3Q5WFcjz34Crajn6u3BT88Pyvp4h7J8JBKtfsgK29r8avu0SidMgDo3siAkfnhNe
         zBOf7jmpSVIvj5TjehwwkiK+70T4ZAeMIsic3v3RHkzNj10Q9j0NKssr+Nf/Fq6UoGZa
         hfUQ==
X-Gm-Message-State: APjAAAUOcwYLD3CBKiNCmU5Nw1FG+MmGOSi/rGm3F5ABRU+WqvUt1ZeP
        rHFAF9OM8tx05a+0X5codp2hlw==
X-Google-Smtp-Source: APXvYqxb2P1Z2gElidhwJE8A1hcT+NpK1Wl8gtsfY3RZsA2RGoHeJKdGP6SxceLXf1qTbiKoMedCEg==
X-Received: by 2002:a05:600c:143:: with SMTP id w3mr6256752wmm.132.1571819972247;
        Wed, 23 Oct 2019 01:39:32 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id h3sm7133607wrt.88.2019.10.23.01.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 01:39:30 -0700 (PDT)
Date:   Wed, 23 Oct 2019 10:39:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Mat King <mathewk@google.com>, Sean Paul <seanpaul@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, rafael@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191023083928.GR11828@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        Mat King <mathewk@google.com>, Sean Paul <seanpaul@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, rafael@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com>
 <20191002102428.zaid63hp6wpd7w34@holly.lan>
 <8736gbbf2b.fsf@intel.com>
 <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
 <87h84q9pcj.fsf@intel.com>
 <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com>
 <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com>
 <CAL_quvTe_v9Vsbd0u4URitojmD-_VFeaOQ1BBYZ_UGwYWynjVA@mail.gmail.com>
 <87sgo3dasg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgo3dasg.fsf@intel.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:13:51AM +0300, Jani Nikula wrote:
> On Mon, 07 Oct 2019, Mat King <mathewk@google.com> wrote:
> > That makes sense; just to confirm can a property be added or removed
> > after the connector is registered?
> 
> You need to create the property before registering the drm device. You
> can attach/detach the property later, but I should think you know by the
> time you're registering the connector whether it supports the privacy
> screen or not.

I don't think you can add/remove a property after the object you're
adding/removing the prop from has gone public (either with
drm_dev_register or drm_connector_register for hotplugged connectors).

I guess another gap we should cover with some WARN_ON?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
