Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F14CC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12492206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570508678;
	bh=0VmXSixXSwee/oUMhLebaHFCFzy9lmcotzkX+VfPcRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kn1J0sFtHQRkjgcnfxcKYJrhDojYph70dP0sC1cq64J7ox877xl6zUB0bigATCbdY
	 GC7tNwX/JL/TjALGwVZy32KbJ4p0TiFreuBj7ALdgdHRZ0Wo0M9gZxaWPoZmIrrolB
	 n4sAw/N4tEJuM0eQC/ehiR0R8RxlKbut4NgiNof8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfJHEYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:24:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45393 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfJHEYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:24:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so15959398ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 21:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ibOtN5zf55brhdHuZKhclLlUWgiBgKFnugDa2ZrV1A=;
        b=QpdIgpspj1uKTJeRIV+rb5IqCsrK/WhrG85qjV26pC9dTDaiih4t0xTBb3STpoRZM8
         jaYC3nDYkrX3Eu4RlO7a92ZHnXWQFD/u6MxVsxrYZlj/42wy+oxwnUITZ1324bcp/G3h
         zA4GaBxcUmaUrESAvwEiD2TuZ7xkaIY1kKoO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ibOtN5zf55brhdHuZKhclLlUWgiBgKFnugDa2ZrV1A=;
        b=WL/xqdNn+/TJ36gv0c7fcE8NsGODLXfpkp3zkG3Lh1p+ySoxYrUJF1aKMpuIOcxiTk
         ycRpxGz9m6F39F2vvQGuFjfpQp6f9eHuTWc69BCwHYAb+slhH4Qyjup7FUgpWocfQQKC
         +2EoEqH13RwHN3Fkg/AxwxDZhFzf0MtdNeEUXFtMozjNZViETESfRCggaEPbvwAmHzLW
         pdzC7r+82mXEe+B8ZDRrGSJ8F581UiuAmWS9AiZwkF9o4FyPBQzG8+/UKsbGK+Cf9NON
         KS6bE09I+06LX55jyPg9gaFMDkbe/jwdkY/aCAgriUePT70Pw1BA+AUaGdz3aRZeX0Vc
         37Vw==
X-Gm-Message-State: APjAAAV/thYSy0E79hv52xi2n9Da9wbeokvGyzuwr+nwblycVi5h2x+A
        Q0cMlvhGhlaWJgjK1AREjNIxG+XtPbk=
X-Google-Smtp-Source: APXvYqzoX0PqU6M01BdwBAmdJ70RX8qdCUQy2EUJ/EClDt0GUiaqhplPgcIsmElF6wF0qwYASK6DDQ==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr19771242ljj.187.1570508674610;
        Mon, 07 Oct 2019 21:24:34 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id x15sm4170056lff.54.2019.10.07.21.24.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 21:24:33 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id d1so15944798ljl.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 21:24:33 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr21151541ljf.48.1570508673174;
 Mon, 07 Oct 2019 21:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
In-Reply-To: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 21:24:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
Message-ID: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 9:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Try the attached patch, and then count the number of "rorx"
> instructions in the kernel. Hint: not many. On my personal config,
> this triggers 15 times in the whole kernel build (not counting
> modules).

.. and four of them are in perf_callchain_user(), and are due to those
"__copy_from_user_nmi()" with either 4-byte or 8-byte copies.

It might as well just use __get_user() instead.

The point being that the silly code in the header files is just
pointless. We shouldn't do it.

            Linus
