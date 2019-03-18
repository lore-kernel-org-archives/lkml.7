Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0941FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB882063F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dATTkLqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfCRJZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:25:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44612 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:25:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id a3so10842542pff.11;
        Mon, 18 Mar 2019 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pa4DPAFOWnQ6zUYOSkNYharZDJQ2FJza0ph8uXudwuE=;
        b=dATTkLqyv+NrAwgrUWnEOgW/B/2iztIxXgUBPHmFMFd6QaYTPW1cq43RDJV/oLTjQ3
         5nDzdaExS/HKiRAXbclgSykNFUSQKXaP826W+Y5zwMzkuLL1GaeEUGeX6lF4YOK9c2s3
         hD/I1zYi9zHvhqsvo3Ax7PjMzPzWV/WAlpnLoQkfQHDuU3J6Qs6tgkPQkVmfj7JYG3xy
         dI0qGcz/6Ku6HBBDjPKSklSl5d0mGw+phMnpVsi97+FAGiS1KGdINeE8DdLVvJ0digI0
         hSVi8bpYPJpUikA5dDnnbpthDq+pAU0C7lkvhWZZN12zsGMlViorJNF1AmtGsIBYHvzL
         M6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pa4DPAFOWnQ6zUYOSkNYharZDJQ2FJza0ph8uXudwuE=;
        b=oPDz4BwZiuKv6Nxz7LMd0vMvU2aoQCxx+3YPPBcCZeaqqKKPxNA6jkFjHBDarBwQfn
         ivDTqRh56eMWHxqRTDNTjgTY6x9aHCG4ylYSnnYh4dMV1TgZQIDuvMFWw3jQ2xCeWAhl
         kVRiICp8Z1QF0HHr8xtPzm1Me/mxFOzIutjfXrrn75aD/7HLX8xeft9Li8UpZFx7qg10
         53R2aW8reCjrTT1XNVQWLgFQ+qhn/eOH8/yYHJpHc3pxb2e3iuLmOZeZnB95wINrzBHq
         qLV+z5lbJ+iuVpzPboOWN6g9iHCe2IEVxsx3KzDsd6RiPCsF/kgB0SeIelAuGHktwQ0R
         A1oQ==
X-Gm-Message-State: APjAAAWtj7YEP0GX5t58yuN4w31pJ4zZfca/QzKPar1tHZmELB5c+mg/
        EawHS2dz975aeu7lsH8YSar0C6COW7sjOtWqT9pGbCYN
X-Google-Smtp-Source: APXvYqwZo/4GcBP/jpQtgqsrtI5qxYE0w18rO6SFBjtJkOLg624GhHhuIBWBr9Hgj+skT9BM0Q9+5EKb5U2l/gyGPWw=
X-Received: by 2002:aa7:914f:: with SMTP id 15mr11532527pfi.49.1552901149220;
 Mon, 18 Mar 2019 02:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
 <20190315165800.5058-8-heikki.krogerus@linux.intel.com> <CAHp75VfMyyPEPg8VkmrbF6CeL0_+pPw+KrT5e+aGLsx0rwm=5g@mail.gmail.com>
In-Reply-To: <CAHp75VfMyyPEPg8VkmrbF6CeL0_+pPw+KrT5e+aGLsx0rwm=5g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Mar 2019 11:25:38 +0200
Message-ID: <CAHp75Vfb97GtfqCmim7L1K_oJ4JvpNVuGvc4LYwwV5Qz8X7-6A@mail.gmail.com>
Subject: Re: [PATCH 07/12] platform/x86: intel_cht_int33fe: Provide software
 node for all components
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 10:36 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 15, 2019 at 6:58 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:

> I don't see any problems with code (*), though I hope Hans will have
> chance to test this.

> (*) Means all patches touching PDx86 in this series

To be clear, I implied here Rb or Ab tag on your choice.

-- 
With Best Regards,
Andy Shevchenko
