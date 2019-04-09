Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88835C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575A22084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554828192;
	bh=qoyOD+v3x+mf84bBIxX0hhygERUHZLqfHjmuo4I2XSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LOnyyvzn40plus/IQvKOIm8sW5Zf2gE0DBAXBY38yBX9CvoI2VGI5GwiPSdip+dAm
	 Pz8eH/BJPN8ybRXgO2pJ8uuDsZZoRGDFDyJBh9/tOinaCoVukIR7To62zRzhA9kJeO
	 MGntWxpWvwyBpAa0YRtJR1A6++EwqxbAxxp5wADI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDIQnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:43:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33613 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfDIQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:43:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id j10so16210968otq.0;
        Tue, 09 Apr 2019 09:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YugM0T8nODd+4GQ5iGHz+GQ5SmQR4JkwnCYSPD0kXuQ=;
        b=hQ83FiYR/5qC9Jy4eK7T8NdaGpeHJjS6Qlql8+qh++DBzRqYvL3PAsPNXE6yTkjUqp
         NNwWMtE4tflJ75tPkfDaBOyV9JQl3UWQfbb9e+iiG14pjUnyanK8GSoIR5RSqgFEzPdX
         S7TX0iPrv5BcrM8pQtcq7+DxR7c3bQ45bjMv5WwnACyGgAPiwm0D2Y2KaAKxfNt1Z+6G
         9WhMQ0BqQ0ZskoaT+ary+1hW+1dzMjrTRW6QWDcMElChnf71E5M4VuGNZZkkwWIt8OgW
         yaaRsvtURtDgiNSDP/+yCqcQQvT2Uk8xI/9HNAZG/Aw/p4i4rBY4fWb/h9E94S+p65rw
         dUGQ==
X-Gm-Message-State: APjAAAXDodP1wuH9q6jJS1A1DSmQz3Av93qoiPwaBil+B2lmalJ5gg5V
        L2tcs9gZbwK0lJU8WtIh9mPiPF027nC13v8iyyE=
X-Google-Smtp-Source: APXvYqxtSDEwTTbntrVIkFfs9EJ2wef1fP+IJ83V0sKQtVP6A6D/Rsta+wOR56X3RtSY0OOh7Gp36TM1I4Ea1kDQymM=
X-Received: by 2002:a9d:4b11:: with SMTP id q17mr25143721otf.272.1554828190051;
 Tue, 09 Apr 2019 09:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190329001135.15847-1-changbin.du@gmail.com> <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com> <20190403133613.13f3fd75@lwn.net>
In-Reply-To: <20190403133613.13f3fd75@lwn.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Apr 2019 18:42:59 +0200
Message-ID: <CAJZ5v0gWmmNwiNW=5XgpO6EJw6cAXpwOOePOtuGmR_JzrC+64g@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:36 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 2 Apr 2019 10:25:23 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > There are ACPI-related documents currently in Documentation/acpi/ that
> > don't clearly fall under either driver-api or admin-guide.  For
> > example, some of them describe various aspects of the ACPI support
> > subsystem operation and some document expectations with respect to the
> > ACPI tables provided by the firmware etc.
> >
> > Where would you recommend to put them after converting to .rst?
>
> OK, I've done some pondering on this.  Maybe what we need is a new
> top-level "hardware guide" book meant to hold information on how the
> hardware works and what the kernel's expectations are.  Architecture
> information could maybe go there too.  Would this make sense?
>
> If so, I could see a division like this:
>
> Hardware guide

This is more about documenting the expectations regarding the platform
firmware, so what about firmware-guide instead?

>         acpi-lid
>         aml-debugger (or maybe driver api?)
>         debug (ditto)
>         DSD-properties-rules
>         gpio-properties
>         i2c-muxes
>
> Admin guide
>         cppc_sysfs
>         initrd_table_override

And I would add dsdt-override here.

>
> Driver-API
>         enumeration
>         scan_handlers
>

So what about this:

- Create a new firmware-guide under Documentation and add an acpi/
directory to it for starters.  Put the following files into it:

         acpi-lid
         aml-debugger
         debug (ditto)
         DSD-properties-rules
         gpio-properties
         i2c-muxes

- Add an acpi/ subdirectory to Documentation/admin-guide and put the
following files into it:

         cppc_sysfs
         initrd_table_override
         dsdt-override

- Add an acpi/ subdirectory to Documentation/driver-api and put the
following files into it:

         enumeration
         scan_handlers
