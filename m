Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C769C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF39E2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw5gKSJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCTQGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:06:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40447 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:06:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so2471580edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2KgnULu+5YJyZuYTYJRBzYtX0TzooR9dpGUiNifuUU=;
        b=jw5gKSJJRySxDW9Vml6XwelcPUmGWYlpzjEmSxNIKsEGzKenWyq+rOY6Vq3QpmLmWY
         KCnzU1sIfi+8A23PFdEbROzi8s+aWAX5LW0pND0LkPc+Sc3exK6bdL4fihZZcXkhKyY8
         e3/zqrQ0H2QO7XE6d/5iUQd6cQubtX4XPqJawbVcoQR65aCghSi4bcrZzpeCLrGu6sHE
         EHEI5JwUGBTzwgCQGrqihxhXOhF5AyzAee4d4Qs91JASyQNdq076JoupBSXVRO0ADQ5Q
         rl+NMZXVImhEdJQt3/WsCRSh0Mb3e9VTF1mnQqpbrRuZ/SUQd9M5LUiyWNNT0yNdm+bX
         ywDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2KgnULu+5YJyZuYTYJRBzYtX0TzooR9dpGUiNifuUU=;
        b=fhvbB/Rb66iybFuzz0dWPF6Y4Yuom0ZSBDWA5w+vvDYhvsjLfJjCtTUg6dQ/3zj/24
         pkoJf6ovGGlhHGp/BzCRNt6Gz9PDgGGPgmP9eaVObxvCSz9IBlb6pk2qNbcbnlCBmeM2
         oIommy5FdoMTYgV7zPscIASRnPmCCrM65l8fJbFfsljjTpA46TpZqHjtPK4qHgZVL94e
         fZ9v4gRhnS6j53td/0rn/JxC74NzbgDTjM6wtUHjDzbs6XhXbPMad067pstC1c1LtNA/
         l7lGfhobNCq/jLsCYRZxuHFLPWEMQaOZccQuJb9TkEeYept3Gi5BVtqHAL86Pt2U3D8u
         JVdA==
X-Gm-Message-State: APjAAAVG/TpcyBNnhvKYlwm3fEMoc/EBlUmlHyrx7Xlw7nOKlPJfneQ6
        NMUoyUvu5Swt9fpJcHRy6ql8fCRacCBIrXPLKwQ=
X-Google-Smtp-Source: APXvYqyBVHWYfhp11buJ8FbZzCQP9pZ7Ur53ww/tbMWkjlEOG4DVfLN8YT+6h1DPeRoiAuL144qNFMULsjjdhQ36lzY=
X-Received: by 2002:a17:906:a2c6:: with SMTP id by6mr12018561ejb.134.1553097967890;
 Wed, 20 Mar 2019 09:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190320160318.GA20599@embeddedor>
In-Reply-To: <20190320160318.GA20599@embeddedor>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Wed, 20 Mar 2019 11:05:56 -0500
Message-ID: <CAPp3RGoJmBDDj4QDBMtPkm6UvO1Ena6c31Ft2w0O8__rpuUriQ@mail.gmail.com>
Subject: Re: [PATCH] sgi-xpc: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Cliff Whickman <cpw@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:04 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
...
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Robin Holt<robinmholt@gmail.com>
