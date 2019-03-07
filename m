Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D213C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED87C20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCGAoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:44:12 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:47127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfCGAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:44:11 -0500
Received: from [192.168.1.110] ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPGNn-1hRD9s1HsD-00PeAA; Thu, 07 Mar 2019 01:42:53 +0100
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Pavel Machek <pavel@ucw.cz>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     hpa@zytor.com, Daniel Colascione <dancol@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
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
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <742b4797-9954-fb54-cce8-47fcad750c69@metux.net>
Date:   Thu, 7 Mar 2019 01:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190306230944.GB7915@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RX24RBqb5ICC35Zqw52rqUcecm18ejI+hyOSLvGZU6WbQPWwi11
 3xLAlY52oMYvx4h6yJc0SvDHfyEnRqvwRFV1+15FYTRCPw5lXaLhcjDqUWPi9/fOY4AM7Gb
 4X8++JBmZk7xAoUS7m+kT3seTIzgzXikikLORlxbTG9cEbYcUu3BajoDn1sc3mVETYasdun
 m/S3k66CkoutBgOrNSh0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VL+SIjaSDPc=:PHmemI3a89Rw0tBehAaTg4
 v/IDRyH+oNZ0zKpfdcdBAokE8TwTcCq4M867Lsp0ImscOTbcaK5UGrVO0KpOzr01Nff7UBgs0
 Lzxqhcy2qXTVVy8Robl4Iq3JGKl8wXltTMWiDJZtuZOW+lcRm57TFvxb7D1tQQu9sLv/EhwFa
 mn1m3GU8ZtMa/DqCPIRp6JTangqs0dOxKrXnDIg1FNiWtMLU6fMkobHOhqANtjuCgIMJmUjmB
 meJYjaC1coV0ZIRG7DH/87KSvOWYid2iiH/GVV1WZzxJlMuRHqOs91NYfJUJS7D8ZLgpQdTgu
 ibHgOgO+Cv6jOcSEaGDQ+pmrTlqd/gztKAI4FFhcahAigQf8sGxPky7yGg5yA0MCzOFz+B0k8
 ceBVb2bWQGfSJidxHiD73gQge8Ps7TdqPAvOCFkptkdTXAluVdirZj5E5AcPa4VvuwlkHIapO
 RlQg33q1TwRqnkgzLj5x5pyXAzX+rVkaE7SYM1fi39v0wWNocWh9SOm+rUtE9bYI9BIUarTp5
 TdFvZFJlJe7QPIDoVOcIDKQ6XomUZKUApUBuXZnxhStEgndtLFg31Gz//mvpYfEe2ZZHF35WI
 /uZ3YGtqI50yXNE76Re2l7Udt2pnH5BIxBjHahvyx8CaijA1qr5wF1G73B55Meo/LTQaEkZOY
 RMJdGEJpt5QibdVUbP8D9Uh3/Bim2uSXlOCE+Z5jwIrJJFroOCLTOG4zHs15210IlEQI6NHjN
 SxGy1ztDEq9V5faZie4w+pU+I2tY/U+2nLVE9Cvh2NVrSB73dewNyHEsnEY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.19 00:09, Pavel Machek wrote:

> So your licensing requirements prevent you from having headers in the
> filesystem, but allow module with the headers hidden inside on the
> filesystem?

Maybe it's just because I've missed most of the thread, but which
license requirements exactly could that be ?

The kernel still is GPL, isn't it ? So, any device vendor needs to hand
out the exact kernel source he hat built the image from, anyways.
(by the way: we should start a flash mob action of demanding sources
from the pocket-computers-with-3g vendors, but that's another story ;-))

So, what kind of license issue could it be, which prevents putting the
files (that you'd have to hand out anyways) directly into filesystem,
while allowing them in a .ko in the same filesystem ?

I'm confused.

> Looks like you should just tar xvzf
> this-is-a-kernel-module-I-promise.ko /usr/src/linux/include :-).

We should ask coreutils folks to add an ELF encapsulation to tar ;-)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
