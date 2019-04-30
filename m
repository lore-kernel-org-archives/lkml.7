Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A44C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F071120644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veTmN8Ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfD3Q3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:29:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36610 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfD3Q3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:29:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so2724405pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8CMI/W3q+BSC73DTflngmeta3WjHrDaqS1WHzzkYCk=;
        b=veTmN8YaZ3bNLDr94/iiI2YhDH1dk7szUetYQ4x7FThsIr2WCCAOOppzZgcXwaTV1x
         iaifTKBgUYNlpfmoUIQ58b5TLqg72BgDJLt+5rQEZ+yaJ/agYTsEaMsPgrYrg7mXcRSt
         UQ7KeXvjLfA5h4yBMrCkQf8zUJ7mVQfqu6zVGrwheBEMBPP0CqYFcKDlqhYZ/DE/9b3Y
         vQg63MCbKkW5Godw8bKTv6Eqacr8WJVry7H8vHiz2r0nGdoWnOdJ++kq8DWu3FnAAnno
         4nEXdiZY0lRja41CnQ/cZFRGDg0Y6g3ltiq0mgXmdOAA7XUN+aKQYpM1RgYMk7d1CKSv
         SiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8CMI/W3q+BSC73DTflngmeta3WjHrDaqS1WHzzkYCk=;
        b=PJtzvz2nQmyEPc69pNdErvk1vsMi9q2ILh1AgC33+OPYQKjvoGHaXIt5rxOM1uljtl
         lpTWf4WrpIafEYXE9aKYHJfCXk7jjm/+3EubpX0ob/8w7rQOVIYKvD164UXjbUsGn9BR
         vw5GIjdiLQZiGUwvB9u1AGbo5oHKgrhhFW4eS36KQcVNsMEKteJTU+i6Lp51jMThlz5Y
         qGo1LCECutmAhZ/kzZ9S29ju4tH7A8dpHls5pRB/ZYqZcmzkAY73oosS+O2uRupXd+7O
         X4ILW+sAMfX3Th/LdQcZWKN3dwWmhgr0SG8DJcx+doDWMTUyPLeDtB3mlNd6enGrsEU9
         R3UA==
X-Gm-Message-State: APjAAAWs/fChdz3/h9QeKLIhJrbDHqusJxkZYU4CZJnFfECeYLiEvbel
        F5elC7c0CoZY+fpKKnZ0C1WMzQ3P6QAWl559zoPA4Q==
X-Google-Smtp-Source: APXvYqwAcVVfpquk09wow26pwxwIdNJqiUwANpR/06l/uFpJFmV2MWFMo4DRtnuE3eA8Sgq6jqSi8swP2KVzAKTVWF4=
X-Received: by 2002:a63:cc48:: with SMTP id q8mr528012pgi.202.1556641763398;
 Tue, 30 Apr 2019 09:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <46b3e8edf27e4c8f98697f9e7f2117d6@AcuMS.aculab.com>
 <20190430145624.30470-1-tranmanphong@gmail.com> <CAKwvOdmvA4sO7UsXW4DapO_HKodeWFwA_5FsNe_wVjneZBYYdg@mail.gmail.com>
In-Reply-To: <CAKwvOdmvA4sO7UsXW4DapO_HKodeWFwA_5FsNe_wVjneZBYYdg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Apr 2019 09:29:12 -0700
Message-ID: <CAKwvOdntTmHBinCK0T_8OZ-2ksUHkQBvDyR8WrxZdW=+yu25dw@mail.gmail.com>
Subject: Re: [PATCH V2] of: fix clang -Wunsequenced for be32_to_cpu()
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     robh+dt@kernel.org, Frank Rowand <frowand.list@gmail.com>,
        pantelis.antoniou@konsulko.com, David.Laight@aculab.com,
        hch@infradead.org, Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 9:28 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Apr 30, 2019 at 7:58 AM Phong Tran <tranmanphong@gmail.com> wrote:
> >
> > Now, make the loop explicit to avoid clang warning.
> >
> > ./include/linux/of.h:238:37: warning: multiple unsequenced modifications
> > to 'cell' [-Wunsequenced]
> >                 r = (r << 32) | be32_to_cpu(*(cell++));
> >                                                   ^~
> > ./include/linux/byteorder/generic.h:95:21: note: expanded from macro
> > 'be32_to_cpu'
> >                     ^
> > ./include/uapi/linux/byteorder/little_endian.h:40:59: note: expanded
> > from macro '__be32_to_cpu'
> >                                                           ^
> > ./include/uapi/linux/swab.h:118:21: note: expanded from macro '__swab32'
> >         ___constant_swab32(x) :                 \
> >                            ^
> > ./include/uapi/linux/swab.h:18:12: note: expanded from macro
> > '___constant_swab32'
> >         (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
> >                   ^
> >
> > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
>
> Thanks for the patch.
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/460
> Suggested-by: David Laight <David.Laight@ACULAB.COM>

sent too soon...
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
