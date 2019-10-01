Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43EFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ADC21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfciGDgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbfJALq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:46:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35842 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:46:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so15124587wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tHjd4gdm3EYFGi3d7rmzjd8b5ATclswBSBj6pNCCuo4=;
        b=kfciGDgzcbaaC6jbn/MEfpcIelhCq/8Viax15KDJ/dEjFRgs3d6HGdVqnwJ6TP0Nho
         yEut+/LNh913bWcoyUPFLl4suF6Od4JiwL1grkZnNKZO5JM98REp/0NYVMhmgzsUD/nl
         Wql9TpKS0HL5O3cuqqI6JEW9qg+QrjmiO44y0nkL60CIr18juoq6MjkocLglse3fDTDr
         fnz1TKLdHH1lQH8OXSHmWxVZ8cOgvUtjW2hbcFBm3jv0N2E5oLL9KopTlYFU2D0rxgMo
         JbvmbqiCWEBAY3I0piPM93sixY51FivvPRhfs5GYiiUAc/UF308ADpOu45T41IuSfpSr
         MEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tHjd4gdm3EYFGi3d7rmzjd8b5ATclswBSBj6pNCCuo4=;
        b=q4XTKm6fs5YRc1+oHaJp97wSec7eGtTMu44UVI+MJdLuu/yScwvTBprIh/knTzm4wE
         CNg27FaJLtwmRM51llYlhgpROHFDiiJZ5R8SXWOf5JPJZn83XdAnHF3AsJKmip1s7KGt
         nUh4MDZkEvTwpc01JLZy5eh+LaepC6XFSpCfKaM7uBfkJV6kFWeUECY39j3y44lIbbVh
         O27b+upyXL0H+55n9Sh9U5SRwd3saxVtYySHVdBQuzVaQRlSIsiuGxYyJjO35b1QJ7PT
         ZTx2x91DvOLs/DSoZ45xAnKfu9wMBtlhFoOJ4wXlY1Hdk6GSwEvejZO+XcSwnme6l1Wi
         9Qlw==
X-Gm-Message-State: APjAAAUpOETMzIEjbzAJxw6UW/G0zAU7lq4iASgcq4XzS7mDYAfdQ46s
        a13VyfrMsoRofh1ejCCot2mskA==
X-Google-Smtp-Source: APXvYqwQpblTxOj4x6m4JyNap+/jjIVd29LSWRWFw15HFe/EXenxen3aYr8OtGxjzrSlu+M4i3Ezzw==
X-Received: by 2002:adf:f647:: with SMTP id x7mr16224883wrp.379.1569930415118;
        Tue, 01 Oct 2019 04:46:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id f83sm2546641wmf.43.2019.10.01.04.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:46:54 -0700 (PDT)
Date:   Tue, 1 Oct 2019 12:46:52 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] nsdeps: make generated patches independent of locale
Message-ID: <20191001114652.GD253280@google.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-8-yamada.masahiro@socionext.com>
 <20190927132726.GB187147@google.com>
 <CAK7LNARQZ49jvPOK5Dg3B7Nog7+zHsAn5=1oHH6hz9ZzJ=S+xA@mail.gmail.com>
 <20190927181414.GB1804168@kroah.com>
 <CAK7LNAQh12iuAk5aoeHhZ=iGcYraWFfsei-+VqwALbOPrrjWdg@mail.gmail.com>
 <CAK7LNAR7QwfMRKwc1DwaRQW3GA-tBHhSv=yVq+xR_YkpYAnc6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNAR7QwfMRKwc1DwaRQW3GA-tBHhSv=yVq+xR_YkpYAnc6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 10:30:27AM +0900, Masahiro Yamada wrote:
>On Sun, Sep 29, 2019 at 10:18 AM Masahiro Yamada
><yamada.masahiro@socionext.com> wrote:
>>
>> On Sat, Sep 28, 2019 at 3:14 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >
>> > On Sat, Sep 28, 2019 at 12:42:28AM +0900, Masahiro Yamada wrote:
>> > > On Fri, Sep 27, 2019 at 10:27 PM Matthias Maennich <maennich@google.com> wrote:
>> > > >
>> > > > On Fri, Sep 27, 2019 at 06:36:03PM +0900, Masahiro Yamada wrote:
>> > > > >scripts/nsdeps automatically generates a patch to add MODULE_IMPORT_NS
>> > > > >tags, and what is nicer, it sorts the lines alphabetically with the
>> > > > >"sort" command. However, the output from the "sort" command depends
>> > > > >on locale.
>> > > > >
>> > > > >Especially when namespaces contain underscores, the result is
>> > > > >different depending on the locale.
>> > > > >
>> > > > >For example, I got this:
>> > > > >
>> > > > >$ { echo usbcommon; echo usb_common; } | LANG=en_US.UTF-8 sort
>> > > > >usbcommon
>> > > > >usb_common
>> > > > >$ { echo usbcommon; echo usb_common; } | LANG=C sort
>> > > > >usb_common
>> > > > >usbcommon
>> > > > >
>> > > > >So, this means people might potentially send different patches.
>> > > > >
>> > > > >This kind of issue was reported in the past, for example,
>> > > > >commit f55f2328bb28 ("kbuild: make sorting initramfs contents
>> > > > >independent of locale").
>> > > > >
>> > > > >Adding "LANG=C" is a conventional way of fixing when a deterministic
>> > > > >result is desirable.
>> > > > >
>> > > > >Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > > > >---
>> > > > >
>> > > > > scripts/nsdeps | 2 +-
>> > > > > 1 file changed, 1 insertion(+), 1 deletion(-)
>> > > > >
>> > > > >diff --git a/scripts/nsdeps b/scripts/nsdeps
>> > > > >index 964b7fb8c546..3754dac13b31 100644
>> > > > >--- a/scripts/nsdeps
>> > > > >+++ b/scripts/nsdeps
>> > > > >@@ -41,7 +41,7 @@ generate_deps() {
>> > > > >               for source_file in $mod_source_files; do
>> > > > >                       sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
>> > > > >                       offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
>> > > > >-                      cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
>> > > > >+                      cat $source_file | grep MODULE_IMPORT_NS | LANG=C sort -u >> ${source_file}.tmp
>> > > >
>> > > > I would prefer to have this set throughout the whole runtime of the
>> > > > script. Otherwise we likely see a followup patch. So, either as an
>> > > > export at the beginning of this file or as part of the command that
>> > > > calls this script.
>> > >
>> > >
>> > > I prefer to keep it close to the locale-dependent code.
>> > >
>> > >
>> > >
>> > > If I move it to somewhere else, I need to add a comment like
>> > >
>> > > # make "sort" command deterministic
>> > > export LANG=C
>> > >
>> > > Otherwise, people would have no idea why it is needed.
>> >
>> > A comment is fine, it documents why it is here and it keeps anyone from
>> > having to remember to add it to anything else that changes in here.
>> >
>> > thanks,
>> >
>> > greg k-h
>>
>>
>> Huh, people who live in a country with English as mother tongue
>> cannot understand the i18n because English is the
>> only language in the world?
>
>I take back this comment.
>I actually do not know where you live, or what native language you speak.
>It was used to exaggerate things, but It is not important to
>the point of discussions. Sorry.

Thanks for pointing this out and reminding us! I am not a native English
speaker, but often are surrounded by English, especially when
programming. Error messages in my native language feel often rather
funny than helpful, but I guess this not the case for most translations.
Based on that I am ok with your original version of the patch.

Cheers,
Matthias
