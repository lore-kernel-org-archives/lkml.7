Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D49C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F86216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MHFCKRKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfGEDQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 23:16:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43160 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGEDQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:16:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so3622376pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 20:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aWklrXUceZD8WSljMzr7F6TlSTq4WKBAsYdg+zJZVhI=;
        b=MHFCKRKVxGKWHPIfO8W5iuXr495O9SFT/TeCt0ZWUdRvy7+7ekE72jxHrzKuvLdwyn
         vbR90wFznfusbmoc6KR+sOlWZaFBzUbn2uF9YwA+a08wsdR1CWKOXRkliMuEhMhr+aVW
         7NnV0cZCd3R0+wvJVvPn40jksBODj0mQjmr5dJvvWZmpH43nK7wf+Bapihhh/3KqE7Nn
         56D8FATpQTroniDi9v1mSWjWfheg46Z5TFeEHzblEbAUhX2Xutc4p8NihMYzyY/eD9lr
         y5XSBWN0QyIcepxU44Adkj2e8y/DRjjEAcq7ODXd8yj7KQLC9syQAs7ZDDaaJwpjhMP6
         6IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aWklrXUceZD8WSljMzr7F6TlSTq4WKBAsYdg+zJZVhI=;
        b=hqTXqmctsZa5fOb78Hfz5T0sjUJFl4RkCUk2N/vORHPmAtDai8EWaZ3fmPS7Ng7E+u
         2cIidjh1eUXjpH8vM5IEPP4+75h18UxOMEZn1Rgg/7vpH3AUWyvqHXrslN6u5LcuZyKT
         k0dngB/PtECPUXIfWry3szZ6FLvtNLawBxxFROt8OVNQnt8IjhThRCQVcfIl51TKizj9
         ZvA2ElSNCvauAIDbEEpKiH4jHXdLkbc5AkXTSo6QfE9bBCCh4KZnjeTe/0wGgMTFQhtM
         2jo2FvXKZ4yK9PdMd7Ch/EfcsGjppxLqhbhYRp44SWYK85BZr003p1PD91uIYCDZ2DUl
         7bhQ==
X-Gm-Message-State: APjAAAVk7/HJR3wUM6bg07qcPnQkDyjO884WQeBGRiZFgyfaQzFIlEVu
        ovo4EWevNoriSKK84wECSB8pIw==
X-Google-Smtp-Source: APXvYqw5wQyyL82304SapsCuO9n5prx2LXfD/Z/YKvWKePCnESkndYFYZZUKT5wKvCDB6JrtNMo0jQ==
X-Received: by 2002:a63:4f46:: with SMTP id p6mr2106430pgl.268.1562296617581;
        Thu, 04 Jul 2019 20:16:57 -0700 (PDT)
Received: from ?IPv6:2600:1010:b00c:9a6b:b5fb:b920:a52a:98a0? ([2600:1010:b00c:9a6b:b5fb:b920:a52a:98a0])
        by smtp.gmail.com with ESMTPSA id p2sm9214590pfb.118.2019.07.04.20.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 20:16:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
Date:   Thu, 4 Jul 2019 20:16:54 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <41D6F2E2-C4CF-41DF-A843-FCBD03B7BEEB@amacapital.net>
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org> <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 4, 2019, at 7:18 PM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
>> On Fri, Jul 5, 2019 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>=20
>> Despire the current efforts to read CR2 before tracing happens there
>> still exist a number of possible holes:
>=20
> So this whole series disturbs me for the simple reason that I thought
> tracing was supposed to save/restore cr2 and make it unnecessary to
> worry about this in non-tracing code.
>=20
> That is very much what the NMI code explicitly does. Why shouldn't all
> the other tracing code do the same thing in case they can take page
> faults?
>=20

If nothing else, MOV to CR2 is architecturally serializing, so, unless there=
=E2=80=99s some fancy unwinding involved, this will be quite slow.=
