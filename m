Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E524C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6702B20883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaDGUarq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfE1Hxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:53:37 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52881 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfE1Hxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:53:35 -0400
Received: by mail-it1-f193.google.com with SMTP id t184so2767560itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwpZM8H7YLCCXst1uTeA0ehiQjYxPanrQx8rycjOA8Q=;
        b=PaDGUarqrwpn2WcZZXubIFwn/6XV9UCbOFvCg6kTbDsTzqCLbHOOZ7QtA06c8hxWTV
         vP8X9KiDQuqkX+tx7S57VyKMl/UK4cHRxZMJWdx33DW2ImQsx2YVeFYbnbEMODSZfaZW
         cYTIhj5G5/ydQa71BrGhnw5rQHltAXiD3tX1ZDbrHd6eFJn+oDnwZ+ranKYrTHKbhAcz
         w/x8Cc4gS2RkQh+i2xStLMXPa9FyrgscAalR1ecTPhTwm1kUMAETKylg0DPBDWLIq376
         0M7m/jtHooSIK41pslNmsCzUETVmsCXJ8kEn5GTx1DhynYTeIKSdSj5E/UjUEnurRoZe
         geqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwpZM8H7YLCCXst1uTeA0ehiQjYxPanrQx8rycjOA8Q=;
        b=flejNce1f+hpDGZDTzag/TmNKt+ZK3FxawTg71bJX0zDCAry9JeYu5ocmdSVwc5/Fz
         K1wppN671nQgH5o3LSW9ctNDPs/mPw0Rsar+motjbf/f5lExaIRjlY9ZiA1v9vQ6dUTz
         u4FPWnuuSn+Fw8vYpS99PnVc3tuc4G52PC4tvU7kx3t6euc8qLZ7rPQOwd/FWda5Mlwm
         jjFM3+Q/gMM/M3BJQQ6lsTkycnaqKEfmApr1Kb0/IgOeKRSzq96GbRIl/wSGAtypJvJh
         o93dtdCYjTiUcLjaDHerE0ulbMhv+wEKM93cBPGdlzz4tgixhLC1cyH1weuTvA7sk6dP
         5lcA==
X-Gm-Message-State: APjAAAWmL3+zjw7fqI8n4xB7dQSUFFlFbsCGvX7iHSJQTMMe4kFqQDJX
        Bs6fmqwR1rCGEr/IYRh8Ac8zGYTmOlZq9zZyufrOXw==
X-Google-Smtp-Source: APXvYqx4v3128ddJmwxIcyynhnVz7bSpXbvNiRgGqgnx1+rCJVGoTIJ3VybznY4MnF7+otMs/Z93UfFghNBLkkLjS4c=
X-Received: by 2002:a24:3cb:: with SMTP id e194mr1991692ite.132.1559030014542;
 Tue, 28 May 2019 00:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190521105203.154043-1-darekm@google.com> <16889839-b4e9-9984-2e36-5f07ceb7d7f2@xs4all.nl>
In-Reply-To: <16889839-b4e9-9984-2e36-5f07ceb7d7f2@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Tue, 28 May 2019 09:53:23 +0200
Message-ID: <CALFZZQH7-mzRZbji1w-UwRLdw6c8+CThn0e96oG8E2Eq1ivANQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] media: cec: expose HDMI connector to CEC dev mapping
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:21 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Dariusz,
>
> I did some more testing with the Khadas VIM2 and found another problem,
> something that will, unfortunately, require some redesign.
>
...
>
> The other problem is in the CEC driver: it creates the CEC device as
> soon as the HDMI device is found (cec_notifier_parse_hdmi_phandle).
>
> But that doesn't mean that the HDMI device also had registered itself
> as a CEC notifier.
>
> Until now that never mattered: as long as the HDMI device was found
> the CEC adapter would function fine, it would just have no physical
> address until so notified by the HDMI device once it registered its
> CEC notifier.
>
> But if we want to have valid connector info during the lifetime of
> the CEC adapter, then this no longer works.
>
> I'm not entirely sure how to handle this.
>
> Another issue here is that when the HDMI driver removes the notifier,
> then it should also zero the connector info. Remember that both the
> HDMI and the CEC drivers can be loaded and unloaded independently from
> one another.
>
Given all of the above, what do you think about coming back to the v1
of the patch, where a connector info could be set on an adapter at any
time and an event was used to notify userland when that happened? That
approach seems to cover all the scenarios mentioned above.

Thank you for testing the patches!

Best regards.
