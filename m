Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1686CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA53214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U26NV0Rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404570AbfJWKtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:49:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40151 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390379AbfJWKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:49:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so19141778wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x9Us54scadrFU9TiJRijJVT2Q9RuXcN3VvdzhxCj4XY=;
        b=U26NV0Rn2z8GAYz7San694T0J7eRwl0thTNtkgIkNJbPPn3lCOykKiV+flHFRJpwC+
         EL/N+kAKyd2IGN8eHHgGMBT06Zh2c9WBVfFzIdUDcC3SSQVULEqtMv+OzEpDSToN0OFD
         WEyTLxg8vnRRUxk1WnWTlJgjqlCJMDyjJ8PJKS3azVFAQD2Q1uuRG1jMq7oo05lcpyzq
         E7cy1R7pTtSxN0OH34YhoAu4Ox6cAcp+CpwdU5fwa/V8T2vTJ8Xr1VNORzokC77qk98Q
         zjIPIb0BLVk0cJT1BT7EbBtrSsNOznmZRlGdVN+x5r959X4DWLWDfcIerfX6StGUQ+RW
         zy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x9Us54scadrFU9TiJRijJVT2Q9RuXcN3VvdzhxCj4XY=;
        b=TUCh6diRCEnanluTGcesDiSJrHf+3QinvKnIaFBB9De8wLdXZ8J4pn4ZJSDM0Gw91i
         82oWOzcMjI3+o+VMopBv5c5I/kqPuZOmVrucQ+hWxBzL7akBHG3CctC/TED16z9AInN6
         5S4FYbUFIhX77eFzpO9TEaqH6QOBbjfUfnpj/G4qwLJhmKypARVsfd2DF4nK8nSl0heM
         VqG7LDY3Tvnq1hphQpSriRvG40qID+fwQagreey4HYfiEKLz8YfD00nkCAe7oPePVhvq
         W+3nggLvWSHGltJnO18L7gJ6UlKxQDKUkj+1u/+d440je0rd6wHRoDtEAQWXhnbYAIA+
         yYxQ==
X-Gm-Message-State: APjAAAULlUjVClCFubYDurITEjXBj5OMBcJfwAbXeI6UXYOqqjfBSDGi
        +OhXAHpwnuLEMTy5ir8Qjat1zg==
X-Google-Smtp-Source: APXvYqygvI1eXHgm4oUC8Ldg/5UwX2sIRJ8S+0hGdEWx4GhRDVei8QAywYaoDflMC0ZQnEAqV+p+1g==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr15921wmb.18.1571827781378;
        Wed, 23 Oct 2019 03:49:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id w18sm3945309wrl.75.2019.10.23.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:49:40 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:49:40 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: Module loading problem since 5.3
Message-ID: <20191023104940.GD27616@google.com>
References: <20191014085235.GW16384@42.do-not-panic.com>
 <20191014144440.GG35313@google.com>
 <20191016125030.GH16384@42.do-not-panic.com>
 <20191016133710.GB35139@google.com>
 <20191018121848.GB11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018121848.GB11244@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:18:48PM +0000, Luis Chamberlain wrote:
>On Wed, Oct 16, 2019 at 02:37:10PM +0100, Matthias Maennich wrote:
>> On Wed, Oct 16, 2019 at 12:50:30PM +0000, Luis Chamberlain wrote:
>> > On Mon, Oct 14, 2019 at 03:44:40PM +0100, Matthias Maennich wrote:
>> > > Hi Luis!
>> > >
>> > > On Mon, Oct 14, 2019 at 08:52:35AM +0000, Luis Chamberlain wrote:
>> > > > On Fri, Oct 11, 2019 at 09:26:05PM +0200, Heiner Kallweit wrote:
>> > > > > On 10.10.2019 19:15, Luis Chamberlain wrote:
>> > > > > >
>> > > > > >
>> > > > > > On Thu, Oct 10, 2019, 6:50 PM Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>> wrote:
>> > > > > >
>> > > > > >        MODULE_SOFTDEP("pre: realtek")
>> > > > > >
>> > > > > >     Are you aware of any current issues with module loading
>> > > > > >     that could cause this problem?
>> > > > > >
>> > > > > >
>> > > > > > Nope. But then again I was not aware of MODULE_SOFTDEP(). I'd encourage an extension to lib/kmod.c or something similar which stress tests this. One way that comes to mind to test this is to allow a new tests case which loads two drives which co depend on each other using this macro. That'll surely blow things up fast. That is, the current kmod tests uses request_module() or get_fs_type(), you'd want a new test case with this added using then two new dummy test drivers with the macro dependency.
>> > > > > >
>> > > > > > If you want to resolve this using a more tested path, you could have request_module() be used as that is currently tested. Perhaps a test patch for that can rule out if it's the macro magic which is the issue.
>> > > > > >
>> > > > > >   Luis
>> > > > >
>> > > > > Maybe issue is related to a bug in introduction of symbol namespaces, see here:
>> > > > > https://lkml.org/lkml/2019/10/11/659
>> > > >
>> > > > Can you have your user with issues either revert 8651ec01daed or apply the fixes
>> > > > mentioned by Matthias to see if that was the issue?
>> > > >
>> > > > Matthias what module did you run into which let you run into the issue
>> > > > with depmod? I ask as I think it would be wise for us to add a test case
>> > > > using lib/test_kmod.c and tools/testing/selftests/kmod/kmod.sh for the
>> > > > regression you detected.
>> > >
>> > > The depmod warning can be reproduced when using a symbol that is built
>> > > into vmlinux and used from a module. E.g. with CONFIG_USB_STORAGE=y and
>> > > CONFIG_USB_UAS=m, the symbol `usb_stor_adjust_quirks` is built in with
>> > > namespace USB_STORAGE and depmod stumbles upon this emitting the
>> > > following warning (e.g. during make modules_install).
>> > >
>> > >  depmod: WARNING: [...]/uas.ko needs unknown symbol usb_stor_adjust_quirks
>> > >
>> > > As there is another (less intrusive) way of implementing the namespace
>> > > feature, I posted a patch series [1] on last Thursday that should
>> > > mitigate the issue as the ksymtab entries depmod eventually relies on
>> > > are no longer carrying the namespace in their names.
>> > >
>> > > Cheers,
>> > > Matthias
>> > >
>> > > [1] https://lore.kernel.org/lkml/20191010151443.7399-1-maennich@google.com/
>> >
>> > Yes but kmalloc() is built-in, and used by *all* drivers compiled as
>> > modules, so why was that an issue?
>>
>> I believe you meant, "why was that *not* an issue?".
>
>Right.
>
>> In ksymtab, namespaced symbols had the format
>>
>>  __ksymtab_<NAMESPACE>.<symbol>
>>
>> while symbols without namespace would still use the old format
>>
>>  __ksymtab_<symbol>
>
>Ah, I didn't see the symbol namespace patches, good stuff!
>
>> These are also the names that are extracted into System.map (using
>> scripts/mksysmap). Depmod is reading the System.map and for symbols used
>> by modules that are in a namespace, it would not find a match as it does
>> not understand the namespace notation. Depmod would still not emit a
>> warning for symbols without namespace as their format did not change.
>
>Can we have a test case for this to ensure we don't regress on this
>again? Or put another way, what test cases were implemented for symbol
>namespaces?

While modpost and kernel/module.c are the tests at build and runtime
resp. to enforce proper use of symbol namespaces, I could imagine to
test for the proper layout in the ksymtab entries (note, as mentioned
earlier there are some fixes in flight to finalize the layout).
In addition, I could imagine adding a test that tries to load a module
that uses symbols from a namespace without importing it. The kernel
should deny loading or complain about it (depending on the
configuration). These are also some of the test cases I had when working
on that feature. I did not implement these as automated tests though. I
will put that on my list but help with that would be very welcome.

Cheers,
Matthias

