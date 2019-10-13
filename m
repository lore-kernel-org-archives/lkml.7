Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E95C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C173920679
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmiduzxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfJMTCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:02:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfJMTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:02:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so1279986wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PxCXXBhA2C4YLbbTIZsjjSPm4uyCjLfswHazHo9DGq8=;
        b=PmiduzxgZfYZ4Y4miFLkBY+Tvs4U8DF0tCoOdP6wlSkN/AU0MkesEU1lPjXphgh6lI
         noVBN680XLK9ZWCPkAFIR0BYJ/DUjzyOmf5H+9Fyv0hdDDCUNBdrK15k/APgabD1a0bZ
         Fj2wih9jCXW9zok/Oja5/1BCrCkjxiIQBYyq35bzaMjis57OIJn1T8b4UKuII8elh92p
         rzn3YMGVArTbuIu86t/iu4/fAgGxUI0DIBi/8lZ5KgiqI6th8FDG1D6ncWkwW3nb4KKR
         MBI9biz7oh1SxCMyZnqC4lGoGphiyZlMis+EUj+hnWq1TjcfP6KBjzN8ZHRlaR5Hc5ho
         RlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PxCXXBhA2C4YLbbTIZsjjSPm4uyCjLfswHazHo9DGq8=;
        b=JEtEPVgdB7SgYTflg5uNzq/D2Fp11O7K44ij6dqF8kgP0Gmf08K0oftC7o+q8O2hcG
         MITNfVHqZp3iITcbrNdUMkw9oAAqzNoUKxto8ehWQrd/m6NMZBFMOCUOz98kP2+fYQP5
         +bICpGWTAXtdbFs0ZPTocuDuWbGvtW/AnM/N1AD9Mgo0t3cphSN9deRbNUt8fMflYNFI
         9JepLqpcX/XkXfKiyBq2t52Ckp+TBddAL1BlHyj8e4y5OkVbBuUtV6K0EeS77HDnJ7pS
         DJjZyFUJzEeUleGy1ajJpSw6SDRJ7G3vshACohhjvpGR+pW9QwIFZk27tokvNzm0DUIL
         Pefw==
X-Gm-Message-State: APjAAAUih1otzppR3pE1E0zo9TpWBlONajovFyNjqKiJiPmdLq0oSd+h
        DQBOkXNJrHIK/XkGtHF3aQ==
X-Google-Smtp-Source: APXvYqwRDKLOg2xklbQug/Q9fbWTVahN4YcnnUI3vsVlqSyRaAe/iK25TsO7xBQ0WNFWVQ1TSZIO9g==
X-Received: by 2002:adf:f983:: with SMTP id f3mr22369431wrr.169.1570993338769;
        Sun, 13 Oct 2019 12:02:18 -0700 (PDT)
Received: from ninjabhubz.org (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.gmail.com with ESMTPSA id s1sm23055438wrg.80.2019.10.13.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 12:02:18 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Sun, 13 Oct 2019 20:02:04 +0100 (BST)
To:     Julia Lawall <julia.lawall@lip6.fr>
cc:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        eric@anholt.net, wahrenst@gmx.net, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, daniela.mormocea@gmail.com,
        dave.stevenson@raspberrypi.org, hverkuil-cisco@xs4all.nl,
        mchehab+samsung@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        sbranden@broadcom.com, rjui@broadcom.com, f.fainelli@gmail.com
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: vc04_services: fix lines
 ending with open parenthesis
In-Reply-To: <alpine.DEB.2.21.1910132040140.2565@hadrien>
Message-ID: <alpine.LFD.2.21.1910131951160.13450@ninjahub.org>
References: <20191013183420.13785-1-jbi.octave@gmail.com> <alpine.DEB.2.21.1910132040140.2565@hadrien>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Oct 2019, Julia Lawall wrote:

> 
> 
> On Sun, 13 Oct 2019, Jules Irenge wrote:
> 
> > Fix lines ending with open parenthesis. Issue detected by checkpatch tool.
> > In the process, change driver functions name in the multiple files from:
> > vchiq_mmal_port_parameter_set to vmp_prmtr_set
> > vchiq_mmal_component_disable to vm_cmpnt_disable
> > vchiq_mmal_port_connect_tunnel to vmp_cnnct_tunnel
> > vchiq_mmal_component_enable to vm_cmpnt_enable
> 
> You should say why you change the names.
> 
> As far as I can see, there is no change to the actual function
> definitions, so the code can't compile.  Perhaps that comes later in the
> series, but the elements of the series have to be ordered such that
> compilation is possible after each patch.
> 
> julia
> 

Thanks for the feedback, I am updating it and will be compiling  
each point.
Jules




