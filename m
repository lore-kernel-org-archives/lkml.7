Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D304EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5A2218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfGCQU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:20:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45707 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGCQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:20:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so3485193wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nQQIzDBT5ulmvCv1mGA/eYyAvfwknQmSWGz/saY1kAc=;
        b=JOESdfCQoIoHRB2eTKfNV23yNInWM0Zb+vSLF31T+P+UtXhxdWByAfOsTIl41UBSeA
         BkGeUWMNs3zae/g1oVY/nKDD08F/0Sad2liU2Fd9gPmPsQ2JltUshEqqnGySpPKH0IYb
         SzfUG+DzvQh5OmICwuY4ibN/jx+MYw+DlS2o3xAC994U4xN2Y4Sa+9P0K8ruVhP0/Lhm
         Uebqqur1Ses/h2jedBFm8VBv5fftETcvXR5a9PHf6tPN05vripWM85iKy/X1PgEUmO9r
         /R5j5yUsBxlrh5esgKFr698S4vg9NKKD0OKlqWW3ORV0HIOkZd72NKoWV3TmcQyj/myw
         1lXg==
X-Gm-Message-State: APjAAAWSbsl3KwNV0jqweO6yLqJ852ot/6qZgsB7uJWXUUcySi6edlJD
        leAm65jNZB3lskzonGbpKNDrB4RpJgB/1g==
X-Google-Smtp-Source: APXvYqyqSE6CiCMaA3tE51IMPrW8jI0NMG5fLN7BNkcYFfVOQTNzchZ43TBtON7ulLvYVDu5oG/5iA==
X-Received: by 2002:a5d:4681:: with SMTP id u1mr29031344wrq.102.1562170822816;
        Wed, 03 Jul 2019 09:20:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c1d:63cc:b81d:e1a9? ([2001:b07:6468:f312:6c1d:63cc:b81d:e1a9])
        by smtp.gmail.com with ESMTPSA id y24sm2136601wmi.10.2019.07.03.09.20.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:20:22 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] x86 instruction emulator fuzzing
To:     Alexander Graf <graf@amazon.com>, Sam Caccavale <samcacc@amazon.de>
Cc:     samcaccavale@gmail.com, nmanthey@amazon.de, wipawel@amazon.de,
        dwmw@amazon.co.uk, mpohlack@amazon.de, karahmed@amazon.de,
        andrew.cooper3@citrix.com, JBeulich@suse.com, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        paullangton4@gmail.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190628092621.17823-1-samcacc@amazon.de>
 <caaeb546-9aa1-7fd5-496d-a0ec1f759d10@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <537c4950-8b22-c28f-c248-504f8396dd5a@redhat.com>
Date:   Wed, 3 Jul 2019 18:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <caaeb546-9aa1-7fd5-496d-a0ec1f759d10@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/19 11:33, Alexander Graf wrote:
> 
> 
> On 28.06.19 11:26, Sam Caccavale wrote:
>> Dear all,
>>
>> This series aims to provide an entrypoint for, and fuzz KVM's x86
>> instruction
>> emulator from userspace.  It mirrors Xen's application of the AFL
>> fuzzer to
>> it's instruction emulator in the hopes of discovering vulnerabilities.
>> Since this entrypoint also allows arbitrary execution of the emulators
>> code
>> from userspace, it may also be useful for testing.
>>
>> The current 4 patches build the emulator and 2 harnesses:
>> simple-harness is
>> an example of unit testing; afl-harness is a frontend for the AFL fuzzer.
>> The fifth patch contains useful scripts for development but is not
>> intended
>> for usptream consumption.
>>
>> Patches
>> =======
>>
>> - 01: Builds and links afl-harness with the required kernel objects.
>> - 02: Introduces the minimal set of emulator operations and supporting
>> code
>> to emulate simple instructions.
>> - 03: Demonstrates simple-harness as a unit test.
>> - 04: Adds scripts for install and building.
>> - 05: Useful scripts for development
>>
>>
>> Issues
>> =======
>>
>> Currently, fuzzing results in a large amount of FPU related crashes. 
>> Xen's
>> fuzzing efforts had this issue too.  Their (temporary?) solution was to
>> disable FPU exceptions after every instruction iteration?  Some solution
>> is desired for this project.
>>
>>
>> Changelog
>> =======
>>
>> v1 -> v2:
>>   - Moved -O0 to ifdef DEBUG
>>   - Building with ASAN by default
>>   - Removed a number of macros from emulator_ops.c and moved them as
>>     static inline functions in emulator_ops.h
>>   - Accidentally changed the example in simple-harness (reverted in v3)
>>   - Introduced patch 4 for scripts
>>
>> v2 -> v3:
>>   - Removed a workaround for printf smashing the stack when compiled
>>     with -mcmodel=kernel, and stopped compiling with -mcmodel=kernel
>>   - Added a null check for malloc's return value
>>   - Moved more macros from emulator_ops.c into emulator_ops.h as
>>     static inline functions
>>   - Removed commented out code
>>   - Moved changes to emulator_ops.h into the first patch
>>   - Moved addition of afl-many script to the script patch
>>   - Fixed spelling mistakes in documentation
>>   - Reverted the simple-harness example back to the more useful
>> original one
>>   - Moved non-essential development scripts from patch 4 to new patch 5
>>
>> v3 -> v4:
>>   - Stubbed out all unimplemented emulator_ops with a unimplemented_op
>> macro
>>   - Setting FAIL_ON_UNIMPLEMENTED_OP on compile decides whether
>> calling these
>>     is treated as a crash or ignored
>>   - Moved setting up core dumps out of the default build/install path and
>>     detailed this change in the README
>>   - Added a .sh extention to afl-many
>>   - Added an optional timeout to afl-many.sh and made deploy_remote.sh
>> use it
>>   - Building no longer creates a new .config each time and does not
>> force any
>>     config options
>>   - Fixed a path bug in afl-many.sh
>>
>> Any comments/suggestions are greatly appreciated.
>>
>> Best,
>> Sam Caccavale
>>
>> Sam Caccavale (5):
>>    Build target for emulate.o as a userspace binary
>>    Emulate simple x86 instructions in userspace
>>    Demonstrating unit testing via simple-harness
>>    Added build and install scripts
>>    Development scripts for crash triage and deploy
>>
>>   tools/Makefile                                |   9 +
>>   tools/fuzz/x86ie/.gitignore                   |   2 +
>>   tools/fuzz/x86ie/Makefile                     |  54 ++
>>   tools/fuzz/x86ie/README.md                    |  21 +
>>   tools/fuzz/x86ie/afl-harness.c                | 151 +++++
>>   tools/fuzz/x86ie/common.h                     |  87 +++
>>   tools/fuzz/x86ie/emulator_ops.c               | 590 ++++++++++++++++++
>>   tools/fuzz/x86ie/emulator_ops.h               | 134 ++++
>>   tools/fuzz/x86ie/scripts/afl-many.sh          |  31 +
>>   tools/fuzz/x86ie/scripts/bin.sh               |  49 ++
>>   tools/fuzz/x86ie/scripts/build.sh             |  34 +
>>   tools/fuzz/x86ie/scripts/coalesce.sh          |   5 +
>>   tools/fuzz/x86ie/scripts/deploy.sh            |   9 +
>>   tools/fuzz/x86ie/scripts/deploy_remote.sh     |  10 +
>>   tools/fuzz/x86ie/scripts/gen_output.sh        |  11 +
>>   tools/fuzz/x86ie/scripts/install_afl.sh       |  15 +
>>   .../fuzz/x86ie/scripts/install_deps_ubuntu.sh |   5 +
>>   tools/fuzz/x86ie/scripts/rebuild.sh           |   6 +
>>   tools/fuzz/x86ie/scripts/run.sh               |  10 +
>>   tools/fuzz/x86ie/scripts/summarize.sh         |   9 +
>>   tools/fuzz/x86ie/simple-harness.c             |  49 ++
>>   tools/fuzz/x86ie/stubs.c                      |  59 ++
>>   tools/fuzz/x86ie/stubs.h                      |  52 ++
> 
> Sorry I didn't realize it before. Isn't that missing a patch to the
> MAINTAINERS file?

Yeah, and the directory should probably be tools/fuzz/kvm_emulate so as
not to puzzle people.  Also:

- let's limit the scripts to the minimum, i.e. only the run script which
should be something like

#!/bin/bash
# SPDX-License-Identifier: GPL-2.0+

FUZZDIR="${FUZZDIR:-$(pwd)/fuzz}"

mkdir -p $FUZZDIR/in
cp tools/fuzz/kvm_emulate/rand_sample.bin $FUZZDIR/in
mkdir -p $FUZZDIR/out

${TIMEOUT:+TIMEOUT=$TIMEOUT} ${AFL_FUZZ-afl-fuzz} "$@" \
  -i $FUZZDIR/in -o $FUZZDIR/out tools/fuzz/kvm_emulate/afl-harness @@

where people can substitute afl-many.sh or add their own options using
the AFL_FUZZ variable or the command line.  Likewise for screen.

- the build should be just "make -C tools/fuzz/kvm_emulate" and it
should just work.  Feel free to steal the Makefile magic from other
tools/ directories.

- finally, rand_sample.bin is missing.

Otherwise, it looks very nice.

Paolo
