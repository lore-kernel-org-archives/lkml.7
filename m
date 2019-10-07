Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4726AC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1279620659
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEpiYSxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJGGqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:46:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35936 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfJGGqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:46:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so13750011wrd.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GUI4psf4X65BdJQOo61gSGp6sUtBmnqbzSZ33CNSXV8=;
        b=FEpiYSxmONhoUt5laP56BsF0fWG4q4s21EuqxETZc3ZdfjqGbuupdtmD6npjyF59GU
         KxpgfXwe4GMDKQV3KIili9ek7WnqTg9w2nbr+snk0+BLD9uQUbi2kFPkL4LGrUYQP1NC
         MS9paPaiJSAlSJZftOarPjnn/HFBagRdj594dD8P8uWUyz1OiaiYK11/p/lncRWiIh62
         IVsQ6sJZ17dRhCiyWBSk9+s6YbG7iP/6CBI7+k1H6kGqYJeUdZodKslqs3LpUMBA38G+
         RE2M2f5uAzqKewgljtMxpW7MqJofQ5lYrjhXtqbrg4F6fYBoM/nzN4mmVVkfzxorwEHR
         73Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GUI4psf4X65BdJQOo61gSGp6sUtBmnqbzSZ33CNSXV8=;
        b=fPX6CEoA9itsCn+PJoEVTlEPn0CCUvti3IboqRkDS5ZGyoFRmoZhK1iaJ1O0OwpE77
         C8YNPJMdClIGiQfOKkeUMAa3EinKEYRkKd1HOKX9pBlgkX6ktcIy/pPpp8B24WRvv9IE
         9JLCiDfdnMDYpXl2Qe9fYFXMob+qHfCnZPahmFELHlSvFtSCRn6AUq+MLBVptCHeEOge
         DPr2tc7XfGUEPqiHZTKiMkMZx7qOMKwu4N1ajZXXiQxATfBfrB3g+5QbxsIRcTGt5WNt
         yU8W3Bib9bGFL6KJnza1KicCv9bXiEuIcd6StqWH46NUB0G4haF0yc9IBp9a81r3Bkgw
         0XkQ==
X-Gm-Message-State: APjAAAXfGQCN3bF5z8hUCSBRGbuDH0mqak8teM645BZ4NJmQDOZlOJx0
        czhqcRFvMbI5I/BjLiDhdBdimA==
X-Google-Smtp-Source: APXvYqyhWWW0aGEVKCb6oxvqfa/lZVGv/4trvdH+LsZPb816Q763laeVFhXIxGAomICdDu4Y5QRy2Q==
X-Received: by 2002:a5d:62c6:: with SMTP id o6mr20341346wrv.243.1570430792299;
        Sun, 06 Oct 2019 23:46:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id f143sm29345955wme.40.2019.10.06.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 23:46:31 -0700 (PDT)
Date:   Mon, 7 Oct 2019 07:46:31 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] depmod: create and use System.map.no_namespaces
Message-ID: <20191007064631.GB142813@google.com>
References: <20190917231031.81341-1-maennich@google.com>
 <20191004095748.223119-1-maennich@google.com>
 <CAKi4VALPF7r25SJ+9jazeRz612pv_4MmhjOsJ8aumW_JO29VvA@mail.gmail.com>
 <CAK7LNAQ10xCm52PrgUvE=Z+d4BabuATSRpw+kL9Xm=O-ik_Duw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ10xCm52PrgUvE=Z+d4BabuATSRpw+kL9Xm=O-ik_Duw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Oct 05, 2019 at 04:53:56PM +0900, Masahiro Yamada wrote:
>On Sat, Oct 5, 2019 at 3:25 AM Lucas De Marchi
><lucas.de.marchi@gmail.com> wrote:
>>
>> On Fri, Oct 4, 2019 at 2:57 AM Matthias Maennich <maennich@google.com> wrote:
>> >
>> > depmod in its current version is not aware of symbol namespace in
>> > ksymtab entries introduced with 8651ec01daed ("module: add support for
>> > symbol namespaces."). They have the form
>> >
>> >   __ksymtab_NAMESPACE.symbol_name
>> >
>> > A fix for kmod's depmod has been proposed [1]. In order to support older
>> > versions of depmod as well, create a System.map.no_namespaces during
>> > scripts/depmod.sh that has the pre-namespaces format. That way users do
>> > not immediately upgrade the userspace tool.
>> >
>> > [1] https://lore.kernel.org/linux-modules/20191004094136.166621-1-maennich@google.com/
>> >
>> > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>> > Fixes: 8651ec01daed ("module: add support for symbol namespaces.")
>> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
>> > Cc: Jessica Yu <jeyu@kernel.org>
>> > Cc: Martijn Coenen <maco@android.com>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: linux-modules@vger.kernel.org
>> > Signed-off-by: Matthias Maennich <maennich@google.com>
>> > ---
>> >
>> > Please note this depends on the new ksymtab entry format proposed in
>> > https://lore.kernel.org/lkml/20191003075826.7478-2-yamada.masahiro@socionext.com/
>>
>> I don't really agree with that thought, more below.
>>
>> >
>> > That is likely to be merged soon as well as it fixes problems in 5.4-rc*, hence
>> > this patch depends on it.
>> >
>> > Cheers,
>> > Matthias
>> >
>> >  .gitignore        | 1 +
>> >  scripts/depmod.sh | 8 +++++++-
>> >  2 files changed, 8 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/.gitignore b/.gitignore
>> > index 70580bdd352c..5ed58a7cb433 100644
>> > --- a/.gitignore
>> > +++ b/.gitignore
>> > @@ -59,6 +59,7 @@ modules.order
>> >  /vmlinux-gdb.py
>> >  /vmlinuz
>> >  /System.map
>> > +/System.map.no_namespaces
>> >  /Module.markers
>> >  /modules.builtin.modinfo
>> >
>> > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
>> > index e083bcae343f..602e1af072c7 100755
>> > --- a/scripts/depmod.sh
>> > +++ b/scripts/depmod.sh
>> > @@ -39,7 +39,13 @@ if $depmod_hack_needed; then
>> >         KERNELRELEASE=99.98.$KERNELRELEASE
>> >  fi
>> >
>> > -set -- -ae -F System.map
>> > +# Older versions of depmod do not support symbol namespaces in ksymtab entries,
>> > +# hence create an alternative System.map with namespace patched out to use for
>> > +# depmod. I.e. transform entries as follows:
>> > +#    __ksymtab_NAMESPACE.symbol_name -> __ksymtab_symbol_name
>> > +sed 's/__ksymtab_.*\./__ksymtab_/' System.map > System.map.no_namespaces
>>
>> So people with old kmod will have to know they need to pass
>> System.map.no_namespaces rather than the usual
>> System.map. Also, distros will need to be update to also copy the new
>> file to the kernel package (or upgrade/patch kmod).
>>
>> I'd rather maintain the current format and fix the bug that patch is
>> fixing. The namespace
>> in the end IMO is just a small annoyance with a reason to  exist.
>
>I agree, this fix is bad.
>We should not bother kmod or any tools.
>And System.map.no_namespaces is a cheesy workaround.

Thanks for the feedback!

Based on the discussion from last year about changing kmod/depmod for
this change to the ksymtab entries,
(https://lore.kernel.org/lkml/CAKi4VA+wvVxPxVSP6ruSR++TYvavKPNAQ5XhREF_9ZxeOKQirg@mail.gmail.com/),
I assumed this approach would be acceptable. The workaround (yeah, it is
a hack) is a way to mitigate the issue for people that can't update
depmod so easily. System.map.no_namespaces was not intended to be part
of any distribution, but rather used locally in depmod.sh. I could have
made this more clear.

>
>BTW, I expressed my negative opinion in the review process
>for the patch set. I am still not convinced with the
>namespace feature, but anyway it was merged
>(with poor review and test).
>
>
>
>Get back on track, probably the right fix would be to
>stop using __ksymtab_<namespace>.<symbol>.
>
>It is not used for any purposes but passing
><namespace> / <symbol> pairs to modpost.
>
>
>For example, __kstrtabns_##sym points to
>the namespace string, so it would be possible
>to parse it from modpost?
>
>Then, asm("__ksymtab_" #ns NS_SEPARATOR #sym)
>will go away.

I will give this a try.

Cheers,
Matthias

>
>
>Masahiro
>
>
>
>
>> Lucas De Marchi
>>
>> > +
>> > +set -- -ae -F System.map.no_namespaces
>> >  if test -n "$INSTALL_MOD_PATH"; then
>> >         set -- "$@" -b "$INSTALL_MOD_PATH"
>> >  fi
>> > --
>> > 2.23.0.581.g78d2f28ef7-goog
>> >
>>
>>
>> --
>> Lucas De Marchi
>
>
>
>-- 
>Best Regards
>Masahiro Yamada
