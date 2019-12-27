Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD71C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA18A20838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mikemestnik-net.20150623.gappssmtp.com header.i=@mikemestnik-net.20150623.gappssmtp.com header.b="Sa0SRAJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfL0Szb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:55:31 -0500
Received: from mail-vk1-f171.google.com ([209.85.221.171]:45629 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0Sza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:55:30 -0500
Received: by mail-vk1-f171.google.com with SMTP id g7so6974348vkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 10:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mikemestnik-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YER3VZVMIabMY6ke1e7HotfVYlW0AfrVFMslSmqVZjs=;
        b=Sa0SRAJsQ7NB5kkcXB1GownCUuOGApcg8CFYL0Nb4DovYhPeBhd+J+WBIzQcXw3ScK
         EAbgNpkFMP6wmseqYI7ZAw+4R9/wBsUVM4YaAxLaTA18LRJ/fhZhm3uvP37YHk4/y+Ro
         1WVQokkJW67eNw+TpF5gZer0r+CPAyjTpPHpmA9IGffGED6XkLeKg5aKJjczPomnQlNG
         0pRJkivVJZn2P1BQyeYacojEeCLHLyVRgh69NYbwNdxAID7gcaVzRG7w0NVCXa333+oE
         +xZKOum3flknXAhcELDWrzpzJMBg0OVNzw1HU9JS58FZBv2ii4U8WgkqnbsleWxVbTwM
         LkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YER3VZVMIabMY6ke1e7HotfVYlW0AfrVFMslSmqVZjs=;
        b=mgQLYBo9CpPzdbJZ65tQHuYodIRLvyJcYrh2BAt03OGDkPJC87URI7KUloMU5e6Sng
         9UBiiaRpUjtAps+0qqt6sHeHQE7hKBucBdG0L69pgy6RyHoUJ1k5oW277ksDJpnzTmQd
         n1f9Q9MEPknvaObGtQF5T9ipbYO8HCd6cc+iErUo42A50pxEhjULnkUSKygW3If6nfa5
         KeruzWwvyIS3v5lweU8tGbgm5VmCipLyLL6mF7PdRKIHwP2BEo6lpzOs/rht427IVgVD
         DQ0hnZbD2CciGBsfkr/A2RwgEdKYLwdScPAz0Zur1wW4RQ8DXY/dcEJLUk2oLUX3CG1e
         bLfA==
X-Gm-Message-State: APjAAAWYSg0dlb/vHwF0XPdfzwpvwerfEyDv0Nw+GdkC3PYdLdjzNIek
        B85klUn4OSPZ1SvGE99yJslPSnjSok+eiB18GqJGXgqaxEQ=
X-Google-Smtp-Source: APXvYqw6H/eCHZ1eyrCG1wNWjoDvL3l84rcgdhg0iA/vV06fFhfETaEmRNG0F4GdxL5Otue+3s+XtSeGlXMKFT7y3kk=
X-Received: by 2002:a1f:e784:: with SMTP id e126mr31873811vkh.102.1577472929260;
 Fri, 27 Dec 2019 10:55:29 -0800 (PST)
MIME-Version: 1.0
References: <CAF8px57Sawr1COPueoXt-Tso++_Vyt=XLfUcXxNvv-M1590cDg@mail.gmail.com>
In-Reply-To: <CAF8px57Sawr1COPueoXt-Tso++_Vyt=XLfUcXxNvv-M1590cDg@mail.gmail.com>
From:   Mike Mestnik <cheako@mikemestnik.net>
Date:   Fri, 27 Dec 2019 12:55:14 -0600
Message-ID: <CAF8px55PxPWd2XAydffT5f0EAXxcUSRgDGR0XhjvSrrpBrq3tA@mail.gmail.com>
Subject: Re: System freeze log.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://paste.debian.net/1122884/

On Fri, Dec 20, 2019 at 10:39 AM Mike Mestnik <cheako@mikemestnik.net> wrote:
>
> https://pastebin.com/k7CqCwPz
