Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA07EC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3FC20659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciR4v8Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbfGPUfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:35:07 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42811 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfGPUfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:35:07 -0400
Received: by mail-vs1-f67.google.com with SMTP id 190so14859056vsf.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTXuJjlx5q7Qe80Yz5WGd6e0nqZG+IooCpGI3pnycJ4=;
        b=ciR4v8OhapnxETOGK7wfTSZ2HGLg5se7oSc+10v/R6wCoaTEmXzWxPDt9oxHC7JyTF
         3OBlmd6OF2VFqqBP5UA5gEGCQpxr6VsxRZq+UJyxjUuhV4fZS+fn5gUYNVQmFqwerA+l
         Dvlk44dSQmMS1DBn+qEEaLADi+7J3vPMB+uAkK8S6qGv2j2B01Am1tLxy/G5/Nq7wpwm
         kELdNFdRDu3OT26VIB9t72SodzeeS67ODNGn6uZA/Izb2C5qi3+K0OTAxcOoFrC5DIFb
         OgPkZr/yEBcciExidG+IrFGISg9uEbuuiV24lVUWbVDYx8i1P5Yb4kZVXHWnuaNhCIS+
         4L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTXuJjlx5q7Qe80Yz5WGd6e0nqZG+IooCpGI3pnycJ4=;
        b=iDtI66TqWeoQ9fg+511F4Nf807st6ly2/GLfmCNg5K7ijbbOL7Uh4f5cKSx0H01lS8
         uYjTxD7BgpiM1uN3bsWdvPNhpNAz+WCo7L751gWGsuifA8Vtin94aA5sqVnT+GzhBh6H
         5JnKLrLP0FJPoBgeueupBQSTCdHtQz6MU+/oFWeW8FgnlQk8E+n0jM7wohv/d/7fwiUX
         RbdiYJvProIQ/DpsVfYe2smM1sknpvWCC1ih1ZBSrSDM9Hax9hg0VK4K0GQqL+fcrDMQ
         TqWPpzeP59DVtQ/p4DAGJNCj8m8T7rOaNZVUii6cO7QhG0BIjez2GDVEwdDMhvFmhlMY
         OGAw==
X-Gm-Message-State: APjAAAXAQe2d22d89GDFunwuCVq95T1e68sLIbOfwnjWq9m5exxq/TSq
        OGYoXhI6P+53VeVYEPp6g2MGDdK0f2xdorHKTV0hJA==
X-Google-Smtp-Source: APXvYqwULruIwhcKPZuWhSs6rndmokQERBpELkF586kigli0sXfpel4ZL/ik7omczmrrcRQVAd0KEsGFYuf4cFnxhF0=
X-Received: by 2002:a67:ff99:: with SMTP id v25mr22116833vsq.158.1563309305642;
 Tue, 16 Jul 2019 13:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-16-matthewgarrett@google.com> <20190716025923.GA5793@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190716025923.GA5793@dhcp-128-65.nay.redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 13:34:54 -0700
Message-ID: <CACdnJuut9cfc1fsAy63t0Z=JVujmNELm2Xm1grEZzORF5Cuviw@mail.gmail.com>
Subject: Re: [PATCH V35 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 7:59 PM Dave Young <dyoung@redhat.com> wrote:
> I'm very sorry I noticed this late, but have to say this will not work for
> X86 with latest kernel code.

No problem, thank you for catching this! I'll update the patch and
send a new version.
