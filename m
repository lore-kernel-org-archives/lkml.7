Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F18BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3077D20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCGXmC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:42:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38737 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCGXmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:42:02 -0500
Received: from [10.175.10.100] ([134.134.139.92])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x27Negpo2390837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Mar 2019 15:40:42 -0800
Date:   Thu, 07 Mar 2019 15:40:37 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190307231207.GA51897@google.com>
References: <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd> <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com> <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com> <CAKOZuesjYZ2EH=BHBAJAFFaTOHjWU7BELJUV3QC9cjXVB2HhUw@mail.gmail.com> <0c46ab5f-8bd6-6916-fc4a-b6f00d456011@metux.net> <CAKOZuevksKGAPif_pUYVzFpbuBCxOZ5WzT6ukLCYm4TzyLUTMw@mail.gmail.com> <5ebec282-57b0-6ebe-0876-ce0dd7b0c11c@metux.net> <20190307205505.GB30028@kroah.com> <5e558126-9038-1ca5-4519-7b5864ca9fa1@metux.net> <20190307231207.GA51897@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel Colascione <dancol@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
From:   hpa@zytor.com
Message-ID: <6773AB0F-C197-4465-80D2-3F7DA28EF790@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2019 3:12:07 PM PST, Joel Fernandes <joel@joelfernandes.org> wrote:
>Enrico,
>
>On Thu, Mar 07, 2019 at 11:11:22PM +0100, Enrico Weigelt, metux IT
>consult wrote:
>> On 07.03.19 21:55, Greg KH wrote:
>> 
>> > Ick, no, no more squashfs please, let's just kill that mess once
>and for
>> > all :)
>> 
>> okay, then: s/squashfs/whatever_fs_image_or_archive_you_like/;
>> 
>> > Again, putting this in a simple compressed tar image allows anyone
>to do
>> > whatever they need to with this.  If they want a full filesystem,
>> > uncompress it and use it there.  If they just want it in-memory
>where
>> > they can uncompress it and then discard it, that works too.
>> 
>> And let me stress the point: doesn't need any kernel changes at all,
>> when it's just a file in the same place where the .ko's live.
>
>Yes, but you're missing the point that some people would also opt to
>build it
>into the kernel during their development/debugging (Config=y). For such
>folks, they don't want to update the FS with anything during debug runs
>either. Your "whole same place where the .ko lives" doesn't address
>Daniel's
>usecase. You may say "initrd", but this is a much cleaner solution to
>that
>IMO. There is no initrd needed and the path to the header files will be
>at a
>standard location that is already pre-decided by the kernel.
>
>As Greg said, you are welcome to keep it disabled for yourself if you
>don't
>want it. This doesn't affect anyone else who doesn't use it.

You do know that initrd can be built into the kernel, right?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
