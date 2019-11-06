Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF0C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7352178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwk05Z47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfKFAff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:35:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44715 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbfKFAff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:35:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so17409940pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nV6+nAXCqKLxAkJ73MkPjCdygA/6kDv8a5/d5YqbKKM=;
        b=iwk05Z47ymun6qVZ2ZqvWQVrNbyrFI4pKJaqVPuEkPVoeZ8TkgQOMYeUjohJyfTxHy
         i35BEo94zplaDsUpCIniLT2yVpRSn0rD/LIMZNRRDFvwzV2sw5aV+CntsHEXnIS5QRWU
         credwKAD1iKpgmUDD//nXU9d/JxDgA1iEl62DNLFnu4wvD4qkNgQ8PPueRPgDYOLgbG/
         wRQ40/pTEPmrga86TUsN55Q89f3ccHt/vgpMxsPdm95ao3HIHGPXqJhoiqMN+sz2D0kx
         L5TvL5vphZGSYA4WnzDDvIMRkLoCjBCDf84EfTVmSdk0cpkisx4MeLqnP8yYmbqeUxse
         0Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nV6+nAXCqKLxAkJ73MkPjCdygA/6kDv8a5/d5YqbKKM=;
        b=MpoK2I5N+qO3U5cjBUMZhfpSHURnfoP6Rw9bOu5FOa04o2erKLyHdlk4TKWeEDJNjZ
         6vuykOJlc9SqQKBB3aEYhTihdwm708tIPATOZCgh0VHrB+79Jvv5NdguzJ5FabATtk4i
         7gvVcHnx/1v9wiLjYH5ivrAvWdGE40aMQpuWMROUuX33UuJS1L5lTsAAJVv2AxzwXHg0
         VksHY4YqEB+jTXvH2nDzgJUnJR09DUk2L8o9Uj3o++rUXOHETeS06xnxnYVPiONdGR+3
         Ph7bZDtHaQqr2s+Ai5nhF/t+r+vzlNeQe0BKmtsbzMiA20m2/C9UF2WXD+1E9qpxx1D+
         c5cQ==
X-Gm-Message-State: APjAAAUrwZOys6X0p5saBr+9xFCzL5NfLn7QDhrGZ7xMUTqZfH5ywLEk
        WazWkahiE/AukopN2KFXmNS9En24CRWjIYH4vmeEFA==
X-Google-Smtp-Source: APXvYqxx7uF9ghHiBuV0xbVds7C5n9sNEWRuLJWVo2JcGIMQ4ueurVpCMm+qC8uxe/bJIIoWwyQx/y3NuBylgqCZee4=
X-Received: by 2002:a63:234c:: with SMTP id u12mr38258741pgm.384.1573000534052;
 Tue, 05 Nov 2019 16:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com> <201910301157.58D0CE4D3@keescook>
In-Reply-To: <201910301157.58D0CE4D3@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Nov 2019 16:35:22 -0800
Message-ID: <CAFd5g47gfEJqRUW1PR1rtgrzekwLVqRRw0iJ4EVRW4xzUiW2Yw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     Iurii Zaikin <yzaikin@google.com>, shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 17, 2019 at 05:33:56PM -0700, Iurii Zaikin wrote:
> > On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> >
> > > +config SECURITY_APPARMOR_TEST
> > > +       bool "Build KUnit tests for policy_unpack.c"
> > > +       default n
>
> New options already already default n, this can be left off.
>
> > > +       depends on KUNIT && SECURITY_APPARMOR
> > > +       help
> > >
> > select SECURITY_APPARMOR ?
>
> "select" doesn't enforce dependencies, so just a "depends ..." is
> correct.
>
> > > +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> > > +       KUNIT_EXPECT_TRUE(test,
> > > +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
> > otherwise there could be a buffer overflow in memcmp. All tests that
> > follow such pattern
>
> Agreed.
>
> > are suspect. Also, not sure about your stylistic preference for
> > KUNIT_EXPECT_TRUE(test,
> >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> > vs
> > KUNIT_EXPECT_EQ(test,
> >                0,
> >                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));
>
> I like == 0.

Oh, I almost missed this. I think the *_EQ(...) is better than the
*_TRUE(...) because the EQ is able to provide more debug information
if the test fails (otherwise there would really be no point in
providing all these variants).

Any objections?

Thanks for the catch Iurii!
