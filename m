Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54EA20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ssezaFnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfCHNmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:42:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40540 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfCHNmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:42:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so14318033lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Na2ICTCaMZ0QcHDv8RWM3swi5O8VFI4ZuZ2NbpUHrhU=;
        b=ssezaFnNfCTxDFxOwKtDQzdR9rpAu8PUWYVEF1UNq8770sFlQv53heVquoasbermH/
         HU4KvcFGnY3tiN4cZfB6C5umE35JPTFc0N20EebyAIxzeHzy4qmgAn0vUTKvAM4P75hD
         wvql1OikAYjzWupCLpGs8N4HH2rn+aPLpu70c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Na2ICTCaMZ0QcHDv8RWM3swi5O8VFI4ZuZ2NbpUHrhU=;
        b=O+Gp9X26g4e/WBfhUnjg9xRgyGiNoM1zXLT9EybkvlLw6Ns+VBRm0SK/NXU2ksnjnG
         Aztwxi5tFySoZoA72vls6mO7psO2EH0SaxvB0FVMJAyshb0YtkKt+QbZQUidfZ4Pze9z
         NfAQlGyS8qcPxTB/4puis2yt7tkqaFEO9dv9yV85ES2oLI8NjfqkNPFvidixZr7ujbIb
         FlCSASJkrnb2UClIFxpmmX7GTX8HQnuuizXsuZuMhuxkcsN3yjl9ezkYQN8M06qBvCeV
         lJ90EIQSLPe67f5aJi50yiELkFMRLqZrvn9WTeebAu91A1xw/y/WNP7ROKmqvk3+9N0/
         0rIA==
X-Gm-Message-State: APjAAAVPs7q64z627qjfg5dILucbFjyRyDMUXq7SbkmmnWHENuqaQPca
        egqpOb9aZscK75fgT/zDum2yN21zdjLPt0eCuMgZIA==
X-Google-Smtp-Source: APXvYqyzWoypEqoT1oITYeUwNCwjb9vm61eT6BS7cBFz9jHtc8tf3vM63v6xdDxXMuteDgdGCzCS0SSwIXDskAdTkuc=
X-Received: by 2002:ac2:51b2:: with SMTP id f18mr10219675lfk.21.1552052563784;
 Fri, 08 Mar 2019 05:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20190301160856.129678-1-joel@joelfernandes.org>
 <CAMuHMdU77UyUs-LvRx-NN_k0Y7MZXQkBdgL2i83veCkvdzeeqA@mail.gmail.com>
 <20190307150343.GB258852@google.com> <CAMuHMdW_7BTZREsnz7uMTToCZ4HDOZboMJH8k8UZica2pB=Jew@mail.gmail.com>
In-Reply-To: <CAMuHMdW_7BTZREsnz7uMTToCZ4HDOZboMJH8k8UZica2pB=Jew@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Mar 2019 05:42:32 -0800
Message-ID: <CAEXW_YQUcA+bnav20tAFQPXYE=epMie4X85diudKs_s-TJ7dsw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Geert,

On Fri, Mar 8, 2019, 3:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > It is just so much easier to use tar + xz at build time, and leave the
> > decompression task to the user. After decompression, the files will live on
> > the disk and the page-cache mechanism will free memory when/if the files fall
> > off the LRUs.
>
> I'm also considering how generic and extensible the solution is.
> What if people need other build artifacts in the future (e.g. signing key to
> load signed modules)?

That sounds like it could be useful. I don't see any reason off the
top why that would not be possible to add to the list of archived
files in the future. The patch allows populating the list of files
from Kbuild using ikh_file_list variable.

thanks,

 - Joel
