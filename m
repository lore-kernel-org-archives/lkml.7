Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C0CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161A720854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gWAXdHWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437047AbfJRQXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:23:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38389 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436477AbfJRQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:23:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so6823817ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2wi/OP6d586EjQAloFweW5u491ag8tawEzsEIxjYjU=;
        b=gWAXdHWezuL7R7MxC2NfJ3S5dFAkcyD/B3wZtCJhaIwbxT+AtYrGGZXYT3PYNaHZPN
         aNxBbzbwcOq5SXNumdwzY4Rf7WSbUPl08miDtH5aWH0SIwtzB/sHoV/tqp9PjY0RJ0k4
         2K+dxm8DfDwbQZ3d5xTscF4fOiP4QI1r+Pl/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2wi/OP6d586EjQAloFweW5u491ag8tawEzsEIxjYjU=;
        b=bpNa/++duce9KUXVO6ans2rdavnyl+0W+EMUyHArXtpGGUNk12aJSeSAjefCREE/9s
         P3M1MNgvQTA57Z6ogrFVkLQR6DkON3w4/+i6I72law1H4MBnwOvcoxB7wawBLq4UPaKt
         LKXMXZKte2WAm6V/2+SRmukjtDoWAtMscW5nJofOltYMCIwfwx5ENbUIYlSTsJIK4NEO
         c8L/Pv/Q/ThY7cx0lkTmShTs1F12XAGXjZTXRE7HX+IpmpEWs+KiCYsmojgKM3d1Tqi/
         VInmT+GMjvMgAm2r4P15Wz+HeFTu0B5P8qTvst3EANae1HL9hldOEwqzzDZ6UOtCag8m
         kJ5A==
X-Gm-Message-State: APjAAAUQcx8Ue9vOOpykOgNbWA2r7Ki4QR4TcFH8B0WjJBHzHQMq6ygz
        wj62XnjHAQEXctRx6fPe36vhYrykbkk=
X-Google-Smtp-Source: APXvYqzPzFWygZaYfNA0I0EhL1TQv2pqdE3D+xmBOXw0sCFH3z7fSf4+symhdvGRyq3cZ/l7pYZLrQ==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr6537269ljc.164.1571415826154;
        Fri, 18 Oct 2019 09:23:46 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z20sm3031320ljk.63.2019.10.18.09.23.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 09:23:45 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a22so6843924ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:23:45 -0700 (PDT)
X-Received: by 2002:a2e:3c05:: with SMTP id j5mr6983552lja.24.1571415824724;
 Fri, 18 Oct 2019 09:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191005101345.146460-1-ikjn@chromium.org> <CAATdQgBQiFnP3+Dtz8EGCRNiCOWRoJ+zK25iESNLPmVJ+exPmw@mail.gmail.com>
In-Reply-To: <CAATdQgBQiFnP3+Dtz8EGCRNiCOWRoJ+zK25iESNLPmVJ+exPmw@mail.gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Fri, 18 Oct 2019 09:23:33 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ-E0qZJj4KwV51k5b6nT1PmOsVsR3GM+i-D5f_34qy1NA@mail.gmail.com>
Message-ID: <CAE_wzQ-E0qZJj4KwV51k5b6nT1PmOsVsR3GM+i-D5f_34qy1NA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: input: Add DT bindings for Whiskers switch
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ikjoon,

On Thu, Oct 17, 2019 at 8:10 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> A gentle ping on adding DT binding for Hammer (1/2).

DT bindings need to be sent to devicetree@vger.kernel.org and Rob
Herring <robh+dt@kernel.org>

Thanks,
Dmitry
