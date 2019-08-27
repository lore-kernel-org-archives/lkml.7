Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B836C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238252070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO4L/q1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfH0P5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:57:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35972 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfH0P5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:57:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so1501117wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=H1torqY/P3gtGJ+ugePzQCECcZOx2AhSiXCBn05NB9k=;
        b=cO4L/q1kzop9jgA86USjSszzVAloN78q3oEiPirAOB4Db/ItlI+x+XMPuN7CWC9Hxz
         tk2oUjnpA4X4MNbxmck1DPpLnTOUFqLeLCfw88rJ2lS8ln2Ys5YFLg30QvIX4uBqbYVd
         XXVfgu39LO7WDOK8AJVUMZM++xiXnHF7e9L2kzsGY77acE3ON6GtDkWv6Ao3vjtVBDZd
         mGJY3BviFYW1l8aWnedED2o/EnJ045qiE/POJ6gPRvJXWhoSTKkS32R1D6hFgoiR69ZG
         cuXcOFrepIps47133hTTMVs8M1exwmU9faHNbp1ivqgvEaJwc1Z6GtH7iuEvh9SDsWYL
         /PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=H1torqY/P3gtGJ+ugePzQCECcZOx2AhSiXCBn05NB9k=;
        b=WEyuRE440WiS/butbV+Jp9TVijt+xFe6oGuVAx3VSDKqMHGI+XeTbxPWf+WgJ+/q3k
         coTOihvTErDZUuDOnZJ0gktFxoQ91M/eXp9lBI3C9uCEXYWK+cx4ZiomxqXyKP4QwQ2p
         d0Pk8dsNIA5C7Soij0SKuZFGCipvEKK7eVE7XcCDoSIVQb4p5Bo5qiAgJd0GOeUpGLFB
         kq2ckTenmGr3UNKh5Wnml5zan/mHcqw9zrHdinzBDwa4ziFaHfcBg4Q/ddOsveuwdpfC
         dz9TzQxh4FyxlbFy7tF5QsrfETIh8M7V+7oi8F4xFhm54N4BxVchk+U1/tSt+DC80Br3
         ezkw==
X-Gm-Message-State: APjAAAV5NRACaXyFYGdd4m1UKGB5VyX1RKY4UCV6s6kt2zak8Tij6gbL
        9oFlu/vSXy2tyQ26J4iZ3D4=
X-Google-Smtp-Source: APXvYqw1eVmS+SjnJwtinntp3LdrJ8JbR6zDEg86MR8gxyYXhMoa2ggTGXf8z78qW/ip4Bnmb32bsw==
X-Received: by 2002:a5d:6742:: with SMTP id l2mr29732445wrw.70.1566921442215;
        Tue, 27 Aug 2019 08:57:22 -0700 (PDT)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id f24sm4084979wmc.25.2019.08.27.08.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:57:21 -0700 (PDT)
References: <20190825055429.18547-1-gregkh@linuxfoundation.org> <20190827133611.GE23584@kadam> <20190827134557.GA25038@kroah.com> <m3d0gqisua.fsf@gmail.com> <20190827154308.GD534@kroah.com>
User-agent: mu4e 1.2.0; emacs 27.0.50
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/9] staging: move greybus core out of staging
In-reply-to: <20190827154308.GD534@kroah.com>
Date:   Tue, 27 Aug 2019 16:57:20 +0100
Message-ID: <m3blwaiotb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
On Tue 27 Aug 2019 at 16:43, Greg KH wrote:
> On Tue, Aug 27, 2019 at 03:30:21PM +0100, Rui Miguel Silva wrote:
>> Hi,
>> On Tue 27 Aug 2019 at 14:45, Greg Kroah-Hartman wrote:
>> > On Tue, Aug 27, 2019 at 04:36:11PM +0300, Dan Carpenter wrote:
>> >> I can't compile greybus so it's hard to run Smatch on it...  I have a
>> >> Smatch thing which ignores missing includes and just tries its best.
>> >> It mostly generates garbage output but a couple of these look like
>> >> potential issues:
>> >
>> > Why can't you compile the code?
>> >
>>
>> I think we are missing includes in some of the
>> greybus header files.
>
> Really?  Where?  Builds fine here and passes 0-day :)
>

Yeah; just sent a patch to fix it.

Cheers,
   Rui
