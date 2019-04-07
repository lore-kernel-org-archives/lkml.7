Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582EDC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F73C20855
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554658489;
	bh=AIjYXb/NBrC9QStzg8kKtbJOemVFRU9IcBa+zSpsXrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gvCovjZ9h3Rn89jKAjLUD6/gvOOZSKQ8lAwOIsqOYKTlUAyqZ0SyyWnZkpI6rw0ir
	 dxQn/7AY/lgQvsytLhMX3t5MOZGLf84YTjLa2KfQtBkY6ekTsVkJm+xSdDTC4B1B8P
	 0dLf8nLf4DMd7HrpS0jOAbZUzijO1YUz9HZYbxDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDGRer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 13:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfDGRer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 13:34:47 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56EE9213F2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2019 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554658486;
        bh=AIjYXb/NBrC9QStzg8kKtbJOemVFRU9IcBa+zSpsXrE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l3x27s8E78AXNkFtYw1UsONXBwhzn7kbjUoRUJsYM1YDaeNL9jRVJokS4bnOUFlaZ
         +6LPSvutVwdOvWb0OuCck3qApJIX8T8sR1FQ4NklPhy/H0bL2PrAAoWrqrjksL1snm
         b3F+J6pob9EAijYL1iC7EcpESECPU7fschL7lby0=
Received: by mail-wm1-f46.google.com with SMTP id h18so12184973wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 10:34:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWFEN1QNGAcUW1ZmuSSUDJoGlbdZaobqJWtTmtdduTtyvXwdt6H
        Nej1NJToUQOHkWxYYadvBP4H4JqNRQYZbvvHAy/NFA==
X-Google-Smtp-Source: APXvYqztYBR0/QPkVgITTFzfLkZ0VuXwKOPaSAAdeFUqr3jIGOkPIq5pwdS1yRNYPQGDsa6IhLx4OTE9+gxHVq3xINc=
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr15409692wmh.9.1554658484952;
 Sun, 07 Apr 2019 10:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190224044400.34975-1-aubrey.li@linux.intel.com> <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 7 Apr 2019 10:34:33 -0700
X-Gmail-Original-Message-ID: <CALCETrVhpqZiBe6zvK+z6HmD9AhK_O_O=2H=PYzBHid4C=SMYQ@mail.gmail.com>
Message-ID: <CALCETrVhpqZiBe6zvK+z6HmD9AhK_O_O=2H=PYzBHid4C=SMYQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        aubrey.li@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 12:32 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, 24 Feb 2019, Aubrey Li wrote:
>
> > The architecture specific information of the running processes could
> > be useful to the userland. Add support to examine process architecture
> > specific information externally.
> >
> > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Arjan van de Ven <arjan@linux.intel.com>
>
> This really lacks
>
> Cc: Linux API <linux-api@vger.kernel.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
>
> Cc'ed now.
>

I certainly understand why you want to expose this info, but would it
make more sense to instead add an arch_status file in /proc with
architecture-specific info?  Or maybe an x86_status field for x86
status, etc.
