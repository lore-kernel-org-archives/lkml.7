Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D14FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CA720868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555431437;
	bh=d3lU4jz0nSeIVmTDC88Q3+CkAqeb5VngB5XFPce+uAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GorinBq+MYfwZ4szmvy7Z3WNx+PxOzY5C8P9hkVURSOFNA6zQNbEt7EAvH1Nqb+Me
	 JXL9dSUOeVT52IxgzXSsRrMUHtBbkGA8Kc501p1Rw5CnWHiLo16FhCTOr22x1nK/bT
	 eqMMFNVscllIJgp7Vv2lGCjJ3AGcbYV866fRPxcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfDPQRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:17:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:17:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so19631544ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2Gvpl6BGIA50/J1TX+cezdKN7xZ09Bpr+WtIIhOiv4=;
        b=XzbrhfFZ8OS7iWU4+Ot2qCi8GDzOl8LZ+PFEFwbbzp+ZEfUBCTsRIpNXElHDgsIV2L
         /GZceDRcsSgDdjbXqwKZCKwqhqI6RM1jNizxdsPnFcPXot7htZ3epCEvP28wpbOGCkjM
         nPkDoXjHG1od/d361Iu2znwwPWcNKfzjg4IFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2Gvpl6BGIA50/J1TX+cezdKN7xZ09Bpr+WtIIhOiv4=;
        b=eoioDBMYcep9WvNJKcJFTeu3W13Vvah78LYC3lZkikJhfjsfenLosUWaqPBn5FnMg2
         GZAq0sMSK6eaC912GSO/Gr1NHzucnKks5mOJhNarzHccwQH54PkWszOdyjlRPtJh/QW5
         9SvnaiVzyYFfcTkLEw6kZr3v68SZilG4tt8iF95q1NFOADftLL47m8rHn1sVzDMc7c9/
         ZsS65y0JYVH0A2Os3fJmPxpyBGMRc+utNzFaxRHCjnpHE62BXi3cLT2mBgVctGJpKCrF
         XDlW+ughzpQWhSpGpyqDxgC+wz9s4/i8ZR9EkS1o2ceukVRIg/8xiKiM5vNJsjADm+af
         zTUg==
X-Gm-Message-State: APjAAAWF6CoFOJrkArdE/+x9ifUAbO2LaiQSoBpxKxqXw4YDK5/+h8ub
        AC9SQSONHctuFf2G2tlkBGjvypmSWPs=
X-Google-Smtp-Source: APXvYqzKwHRxWSrq+JmrIVweUM5VQFw++RnYwOUCSjhl4QL6lRgW3W4GuJcrhTrOpIGgoD2ETck7wg==
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr43376702lje.22.1555431433455;
        Tue, 16 Apr 2019 09:17:13 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id f1sm10169443ljc.73.2019.04.16.09.17.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:17:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f18so19650305lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:17:11 -0700 (PDT)
X-Received: by 2002:a2e:8108:: with SMTP id d8mr18152714ljg.57.1555431431532;
 Tue, 16 Apr 2019 09:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org> <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
In-Reply-To: <20190416140658.2cb73a3f@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Apr 2019 09:16:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
Message-ID: <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 5:08 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> This is not nice, would a patch like the following be acceptable?

Umm.

We actually already *have* this function.

It's called "gup_fast_permitted()" and it's used by x86-64 to verify
the proper address range. Exactly like s390 needs..

Could you please use that instead?

            Linus
