Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05621C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD502168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YqPXUgon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfI3WEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:04:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42900 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfI3WEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:04:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so19028275qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iin0gJR528W5g0jWTS9HSd8at8s87+NF0eywiHCFfo=;
        b=YqPXUgon+HjVegYUs9truqIxP4OeBTdmRhRxsSn9QnGAfLr0bvy1k6JM88cp/ixcRi
         cDAJxitl7M3YcsWmB1HP3zw1iYgVrzMwMNHtNf3C0z6r8y6NBo5yRMRfBhYPIw0Cdn3e
         tSOp25EZ6ri99ORX0O6oWGGiPl2mVRCXn0grE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iin0gJR528W5g0jWTS9HSd8at8s87+NF0eywiHCFfo=;
        b=CbG9G2u3huUU2KiCGylh0Hl9gPlKxK4C6pUnc1Drre8Bfu0GJj9nymXgNUjtmkJSh2
         MmW7E5LOy3RCTgBUq0ljTpSltDo0ouYiiyXtLo/ZCKN35u+fVrztOzyBRFNq2D/JkFjv
         F/UAqvStrMuyt8FYhpm9rLkijSM0P7f2ea17Jtc1j0JxDzahrLMwFK5mEb8CRbAXSNw5
         ro7UYqMlj8xUMD+WSNeNCRBfQRfBqdZdg9pqb36YJFEekOLtMufA1mJK/nu1f42ZJEu5
         hHijlYFGAkEX9kYblksxYt7fHmuGMEjF/EBnyH9UTvwPrIZ3NL2aBvUgvDMLcp1iz9hu
         3lKg==
X-Gm-Message-State: APjAAAUIR1yrT+o+XIGLBIsveM9UC7Y4ShO3IVb/a2V2P2izQGsBIBJL
        YDVxLfqrWEMaAtoAI5KSbkxAnkToDnI=
X-Google-Smtp-Source: APXvYqzY17o3CLWjI0k7esRY33bc5G81AuS1EcHH/MzRnKxu7nb79d5QT/EFBtzvjYU0o1T7kYDg6Q==
X-Received: by 2002:ac8:6c44:: with SMTP id z4mr27424382qtu.229.1569881053407;
        Mon, 30 Sep 2019 15:04:13 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 187sm6374505qki.80.2019.09.30.15.04.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 15:04:12 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id w14so19028147qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:04:12 -0700 (PDT)
X-Received: by 2002:ac8:f1c:: with SMTP id e28mr27107637qtk.161.1569881051791;
 Mon, 30 Sep 2019 15:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190930214522.240680-1-briannorris@chromium.org>
In-Reply-To: <20190930214522.240680-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 30 Sep 2019 15:04:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOkLKqs_Uo4vdHre6JWCsjucgntDEF7T=_eXt2a-A-voA@mail.gmail.com>
Message-ID: <CA+ASDXOkLKqs_Uo4vdHre6JWCsjucgntDEF7T=_eXt2a-A-voA@mail.gmail.com>
Subject: Re: [PATCH] firmware: google: increment VPD key_len properly
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hung-Te Lin <hungte@chromium.org>,
        stable <stable@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 2:45 PM Brian Norris <briannorris@chromium.org> wrote:
> Fixes: 4b708b7b1a2c ("firmware: google: check if size is valid when decoding VPD data")
> Cc: <stable@vger.kernel.org>

Perhaps I should have modified the subject to note the urgency (e.g.,
[PATCH 5.4]). The above regression was recently shipped to v4.14.146
and v4.19.75.

Brian
