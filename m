Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBDAC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AC02175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfCTJEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfCTJEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5771BC049E20;
        Wed, 20 Mar 2019 09:04:10 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-246.pek2.redhat.com [10.72.12.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F01A618C7F;
        Wed, 20 Mar 2019 09:04:06 +0000 (UTC)
Date:   Wed, 20 Mar 2019 17:04:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v4 0/8] selftests/kexec: add kexec tests
Message-ID: <20190320090401.GA2591@dhcp-128-65.nay.redhat.com>
References: <1552588876-28481-1-git-send-email-zohar@linux.ibm.com>
 <20190318140643.GA17706@dhcp-128-65.nay.redhat.com>
 <1552932562.8658.274.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552932562.8658.274.camel@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 20 Mar 2019 09:04:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

Thank you for help about the pointer about IMA testing.
Probably I should cc list as well since we are talking about the patch
itself.  For the ima test itself I could still ask for help in a private
email thread.

On 03/18/19 at 02:09pm, Mimi Zohar wrote:
> On Mon, 2019-03-18 at 22:06 +0800, Dave Young wrote:
> > Hi Mimi,
> > 
> > On 03/14/19 at 02:41pm, Mimi Zohar wrote:
> > > The kernel may be configured or an IMA policy specified on the boot
> > > command line requiring the kexec kernel image signature to be verified.
> > > At runtime a custom IMA policy may be loaded, replacing the policy
> > > specified on the boot command line.  In addition, the arch specific
> > > policy rules are dynamically defined based on the secure boot mode that
> > > may require the kernel image signature to be verified.
> > > 
> > > The kernel image may have a PE signature, an IMA signature, or both. In
> > > addition, there are two kexec syscalls - kexec_load and kexec_file_load
> > > - but only the kexec_file_load syscall can verify signatures.
> > > 
> > > These kexec selftests verify that only properly signed kernel images are
> > > loaded as required, based on the kernel config, the secure boot mode,
> > > and the IMA runtime policy.
> > > 
> > > Loading a kernel image or kernel module requires root privileges.  To
> > > run just the KEXEC selftests: sudo make TARGETS=kexec kselftest
> > > 
> > > Changelog v4:
> > > - Moved the kexec tests to selftests/kexec, as requested by Dave Young.
> > > - Removed the kernel module selftest from this patch set.
> > > - Rewritten cover letter, removing reference to kernel modules.
> > > 
> > > Changelog v3:
> > > - Updated tests based on Petr's review, including the defining a common
> > >   test to check for root privileges.
> > > - Modified config, removing the CONFIG_KEXEC_VERIFY_SIG requirement.
> > > - Updated the SPDX license to GPL-2.0 based on Shuah's review.
> > > - Updated the secureboot mode test to check the SetupMode as well, based
> > >   on David Young's review.
> > > 
> > > 
> > I was trying to review the patches although I'm slow due to something
> > else.
> > 
> > But I still did not setup a IMA testable system, need check your old
> > email about how to setup it.
> 
> (The ima-evm-utils package contains a README with directions.)
> 
> > 
> > A quick testing gives me below results
> > 
> > /* test #1, my default kconfig
> > # NO CONFIG_INTEGRITY compiled in
> > */
> > 
> > make[1]: Nothing to be done for 'all'.
> > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > TAP version 13
> > selftests: kexec: test_kexec_load.sh
> > ========================================
> > selftests: kexec: test_kexec_load.sh: Warning: file
> > test_kexec_load.sh is not executable, correct this.
> > not ok 1..1 selftests: kexec: test_kexec_load.sh [FAIL]
> 
> That's really weird.  Both before and after applying these patches
> test_kexec_load.sh is executable (stable linux-5.0.y).  Could
> something else be preventing it from executing?
> 
> > selftests: kexec: test_kexec_file_load.sh
> > ========================================
> > [INFO] kexec_file_load is enabled
> > [INFO] secure boot mode not enabled
> > [INFO] kexec kernel image PE signed
> > [INFO] kexec kernel image not IMA signed
> > kexec_file_load succeeded (possibly missing IMA sig) [FAIL]
> > not ok 1..2 selftests: kexec: test_kexec_file_load.sh [FAIL]
> > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > make: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests'
> 
> This message is because neither CONFIG_KEXEC_BZIMAGE_VERIFY_SIG or an
> IMA signature is required.  It couldn't read the IMA runtime policy
> rules to determine if an IMA signature is required.  So, it's trying
> to provide a hint as to what happened.
> 
> I'll update the test to see if CONFIG_IMA_APPRAISE is enabled, before
> emitting this message.
> 
> > 
> > /* test #2, enabled IMA kconfigs, simply test without other ima
> > setup eg. use a policy etc. need to follow up some guide to test the
> > ima functionality (TODO..)
> > */
> > 
> > 
> > [root@dhcp-128-65 linux-x86]# make -C tools/testing/selftests TARGETS=kexec run_tests
> > make: Entering directory '/home/dyoung/git/github/linux/tools/testing/selftests'
> > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > make[1]: Nothing to be done for 'all'.
> > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > make[1]: Entering directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > TAP version 13
> > selftests: kexec: test_kexec_load.sh
> > ========================================
> > selftests: kexec: test_kexec_load.sh: Warning: file test_kexec_load.sh is not executable, correct this.
> > not ok 1..1 selftests: kexec: test_kexec_load.sh [FAIL]
> > selftests: kexec: test_kexec_file_load.sh
> > ========================================
> > [INFO] kexec_file_load is enabled
> > [INFO] reading IMA policy permitted
> > [INFO] secure boot mode not enabled
> > No signature verification required
> > not ok 1..2 selftests: kexec: test_kexec_file_load.sh [SKIP]
> > make[1]: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests/kexec'
> > make: Leaving directory '/home/dyoung/git/github/linux/tools/testing/selftests'
> 
> The purpose of these tests was to coordinate kernel image signature
> verification.
> 
> If you require a PE signature, load an IMA policy requiring an IMA
> signature, or even enable CONFIG_IMA_ARCH_POLICY, the test would
> require some form of signature verification.

Did a test with a embedded ima key in kernel, with secure boot disabled,
but with Secure Boot enabled, but failed to sign the kernel with both
pesign and evmctl, will continue to see how to work on it and ask in
private email if needed :)

About the patch itself, as we talked in another email, I would expect it
can work with other test cases eg. without IMA/secure boot.  But if that
is not easy, maybe you can change the test script filename to something
like:  test_kexec_load_sigcheck.sh and test_kexec_file_load_sigcheck.sh 
then we can add other non-sigcheck related cases to other test scripts
later.  But ideally if we can handle them in current files it would be
better.

Another issue I noticed is even if boot with ima_appraise=off, kexec
load still checking the conditions. Will see if I'm having something
wrong in test steps.

Thanks
Dave
