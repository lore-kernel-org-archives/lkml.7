Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421BAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27F1206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfH0GmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfH0GmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:42:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F2977BDAB;
        Tue, 27 Aug 2019 06:42:04 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 644C01001B09;
        Tue, 27 Aug 2019 06:42:03 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:x86/urgent 3/3] arch/x86/kernel/apic/apic.c:1182:6: warning: the address of 'x2apic_enabled' will always evaluate as 'true'
References: <201908270037.RmH8iN2a%lkp@intel.com>
Date:   Tue, 27 Aug 2019 02:42:02 -0400
In-Reply-To: <201908270037.RmH8iN2a%lkp@intel.com> (kbuild test robot's
        message of "Tue, 27 Aug 2019 00:30:41 +0800")
Message-ID: <jpgwoezgldx.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 27 Aug 2019 06:42:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> head:   cfa16294b1c5b320c0a0e1cac37c784b92366c87
> commit: cfa16294b1c5b320c0a0e1cac37c784b92366c87 [3/3] x86/apic: Include the LDR when clearing out APIC registers
> config: i386-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         git checkout cfa16294b1c5b320c0a0e1cac37c784b92366c87
>         # save the attached .config to linux build tree
>         make ARCH=i386 
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    arch/x86/kernel/apic/apic.c: In function 'clear_local_APIC':
>>> arch/x86/kernel/apic/apic.c:1182:6: warning: the address of 'x2apic_enabled' will always evaluate as 'true' [-Waddress]
>      if (!x2apic_enabled) {
>          ^
Thomas, I apologize for the typo here. This is the x2apic_enabled() function.
Should I respin ?

>
> vim +1182 arch/x86/kernel/apic/apic.c
>
>   1142	
>   1143	/*
>   1144	 * Local APIC start and shutdown
>   1145	 */
>   1146	
>   1147	/**
>   1148	 * clear_local_APIC - shutdown the local APIC
>   1149	 *
>   1150	 * This is called, when a CPU is disabled and before rebooting, so the state of
>   1151	 * the local APIC has no dangling leftovers. Also used to cleanout any BIOS
>   1152	 * leftovers during boot.
>   1153	 */
>   1154	void clear_local_APIC(void)
>   1155	{
>   1156		int maxlvt;
>   1157		u32 v;
>   1158	
>   1159		/* APIC hasn't been mapped yet */
>   1160		if (!x2apic_mode && !apic_phys)
>   1161			return;
>   1162	
>   1163		maxlvt = lapic_get_maxlvt();
>   1164		/*
>   1165		 * Masking an LVT entry can trigger a local APIC error
>   1166		 * if the vector is zero. Mask LVTERR first to prevent this.
>   1167		 */
>   1168		if (maxlvt >= 3) {
>   1169			v = ERROR_APIC_VECTOR; /* any non-zero vector will do */
>   1170			apic_write(APIC_LVTERR, v | APIC_LVT_MASKED);
>   1171		}
>   1172		/*
>   1173		 * Careful: we have to set masks only first to deassert
>   1174		 * any level-triggered sources.
>   1175		 */
>   1176		v = apic_read(APIC_LVTT);
>   1177		apic_write(APIC_LVTT, v | APIC_LVT_MASKED);
>   1178		v = apic_read(APIC_LVT0);
>   1179		apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
>   1180		v = apic_read(APIC_LVT1);
>   1181		apic_write(APIC_LVT1, v | APIC_LVT_MASKED);
>> 1182		if (!x2apic_enabled) {
>   1183			v = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
>   1184			apic_write(APIC_LDR, v);
>   1185		}
>   1186		if (maxlvt >= 4) {
>   1187			v = apic_read(APIC_LVTPC);
>   1188			apic_write(APIC_LVTPC, v | APIC_LVT_MASKED);
>   1189		}
>   1190	
>   1191		/* lets not touch this if we didn't frob it */
>   1192	#ifdef CONFIG_X86_THERMAL_VECTOR
>   1193		if (maxlvt >= 5) {
>   1194			v = apic_read(APIC_LVTTHMR);
>   1195			apic_write(APIC_LVTTHMR, v | APIC_LVT_MASKED);
>   1196		}
>   1197	#endif
>   1198	#ifdef CONFIG_X86_MCE_INTEL
>   1199		if (maxlvt >= 6) {
>   1200			v = apic_read(APIC_LVTCMCI);
>   1201			if (!(v & APIC_LVT_MASKED))
>   1202				apic_write(APIC_LVTCMCI, v | APIC_LVT_MASKED);
>   1203		}
>   1204	#endif
>   1205	
>   1206		/*
>   1207		 * Clean APIC state for other OSs:
>   1208		 */
>   1209		apic_write(APIC_LVTT, APIC_LVT_MASKED);
>   1210		apic_write(APIC_LVT0, APIC_LVT_MASKED);
>   1211		apic_write(APIC_LVT1, APIC_LVT_MASKED);
>   1212		if (maxlvt >= 3)
>   1213			apic_write(APIC_LVTERR, APIC_LVT_MASKED);
>   1214		if (maxlvt >= 4)
>   1215			apic_write(APIC_LVTPC, APIC_LVT_MASKED);
>   1216	
>   1217		/* Integrated APIC (!82489DX) ? */
>   1218		if (lapic_is_integrated()) {
>   1219			if (maxlvt > 3)
>   1220				/* Clear ESR due to Pentium errata 3AP and 11AP */
>   1221				apic_write(APIC_ESR, 0);
>   1222			apic_read(APIC_ESR);
>   1223		}
>   1224	}
>   1225	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
