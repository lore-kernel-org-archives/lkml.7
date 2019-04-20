Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D87C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 17:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C8B208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 17:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="B+PiqK/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfDTRCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 13:02:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43284 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTRCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 13:02:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id j20so6626851edq.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXyjmtFFgMWlKGIYoB9dsKU2FQzwdG7rLU5CnRpLzf8=;
        b=B+PiqK/jGA6BSXz4p+5CvV5EJ3gW70B3SIP91bnAfau3Z51YpTAD0mq0/Ml+TJsAo3
         fTBGPm3Uhi6w4qrG48q6HDmiOD9jz1Ih7OOPqQbLaH1nDRoffHPvm9XUPqlNGk7Xpp5b
         PeBDhlrSkWhA7Vv7+eMdCc8tjV0Uj6lotfKsEnWHL6cyXjLpAxuHWN/0plV2RO+WCKtk
         mPQkLmNunc2uwzGPpHzswjKCdqns/uHAHQPps57Z+eHeR4Hw5F4fhorrTlYapLdMuEUb
         eTKDinvPuCb3rOZr91RxUKbrocTtivf/rZJGffYkLG5qk7MnLNqyDOwkUe68G4knPlSW
         Toag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXyjmtFFgMWlKGIYoB9dsKU2FQzwdG7rLU5CnRpLzf8=;
        b=i6J7fhw5gyzQXQdLzoWY8DYlUVflL7ouMypHC3WpYAdu3eUomdcw3ZI09rh+jc/4pz
         zeTLhhm4uXTBna+Vl/Vt3D6q8CvrAYJ8/Tj7jwN+1/Ebn1ADNY/bExXnt4dP8ptt5GLE
         kBj8W7TZgFqTBbHe9AbAugBjFptgvngK3BBUZ2K8d/KiBM6OdxWmWg9plHQ2LIeY4GCM
         2wwTHbxCwmxLudrz/3q6iUVaSwcjJuizzE4m1PYaP1R6NltodgothMmaHM7FUMpSN6YK
         GHbg+/NxOW58lzqainVyD3Hw2D+ldlT1zdyV9Idts0+7T69yb8C5iGUFETIf7zb/M3BU
         gdeQ==
X-Gm-Message-State: APjAAAVCz4EAbuM/m4qYO78FPEEC8K8yig2tCsV+KaVw7JMFuFJs4Du/
        p0CGfwg8gDxtFfPmmnRmG3Cg49r3OoEpUXgdjDHD0Q==
X-Google-Smtp-Source: APXvYqyNourCxDLn0Hoaodp+huVi4LFkIi0+KxD0d7RjeWIUebCBAWlQB16lKvuQTrD2rBAamnZCaw7+I7Zl5DAEd4U=
X-Received: by 2002:a17:906:b291:: with SMTP id q17mr5118998ejz.56.1555779722718;
 Sat, 20 Apr 2019 10:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190420153148.21548-1-pasha.tatashin@soleen.com>
 <20190420153148.21548-3-pasha.tatashin@soleen.com> <CAPcyv4j9sG6Wy3EfTuPb0uZ2qp=gr9UgUhpnXQA_g6Ko9KFmLA@mail.gmail.com>
 <CA+CK2bA2QTzZtFvGRMaG10_TretDr6CGgZc4Hyi_1pku4ECqXw@mail.gmail.com> <CAPcyv4jrxMNEEeUZZG3=CdkYSyX7OtJLv_ZQ1gbML7bscePiQA@mail.gmail.com>
In-Reply-To: <CAPcyv4jrxMNEEeUZZG3=CdkYSyX7OtJLv_ZQ1gbML7bscePiQA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Sat, 20 Apr 2019 13:01:51 -0400
Message-ID: <CA+CK2bA-wDwRT5Gv2p9Nm1Vr8LNg84rQdE6=s2m2hQLYqj5Rog@mail.gmail.com>
Subject: Re: [v1 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thank you for looking at this.  Are you saying, that if drv.remove()
> > returns a failure it is simply ignored, and unbind proceeds?
>
> Yeah, that's the problem. I've looked at making unbind able to fail,
> but that can lead to general bad behavior in device-drivers. I.e. why
> spend time unwinding allocated resources when the driver can simply
> fail unbind? About the best a driver can do is make unbind wait on
> some event, but any return results in device-unbind.

Hm, just tested, and it is indeed so.

I see the following options:

1. Move hot remove code to some other interface, that can fail. Not
sure what that would be, but outside of unbind/remove_id. Any
suggestion?
2. Option two is don't attept to offline memory in unbind. Do
hot-remove memory in unbind if every section is already offlined.
Basically, do a walk through memblocks, and if every section is
offlined, also do the cleanup.

Pasha
