Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D83C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1652147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDDDL0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:11:26 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:44694 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDDLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:11:25 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x343BBEL014267
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Apr 2019 12:11:11 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x343BBUr011511;
        Thu, 4 Apr 2019 12:11:11 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x343BBMk022752;
        Thu, 4 Apr 2019 12:11:11 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3967510; Thu, 4 Apr 2019 12:07:56 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Thu, 4
 Apr 2019 12:07:55 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Prarit Bhargava <prarit@redhat.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools/power: turbostat: make output buffer extensible (Re:
 [PATCH v1] tools/power: turbostat: fix buffer overrun)
Thread-Topic: [PATCH] tools/power: turbostat: make output buffer extensible
 (Re: [PATCH v1] tools/power: turbostat: fix buffer overrun)
Thread-Index: AQHU6pOZTVNV7uauQ0mqERX4jmZH3A==
Date:   Thu, 4 Apr 2019 03:07:55 +0000
Message-ID: <20190404030756.GA22535@hori.linux.bs1.fc.nec.co.jp>
References: <1554274934-12649-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <f3ff449d-f431-4ea6-5c3f-8e19e2c534a8@redhat.com>
In-Reply-To: <f3ff449d-f431-4ea6-5c3f-8e19e2c534a8@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <51D199739C5B2E4B931D2E65D06B4E5D@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prarit,

On Wed, Apr 03, 2019 at 07:42:45AM -0400, Prarit Bhargava wrote:
> 
> 
> On 4/3/19 3:02 AM, Naoya Horiguchi wrote:
> > turbostat could be terminated by general protection fault on some latest
> > hardwares which (for example) support 9 levels of C-states and show 18
> > "tADDED" lines. That bloats the total output and finally causes buffer
> > overrun.  So let's extend the buffer to avoid this.
> > 
> > This patch also removes duplicated "pc10:" line to reduce buffer usage.
> > 
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git v5.1-rc3-mmotm-2019-04-02-17-16/tools/power/x86/turbostat/turbostat.c v5.1-rc3-mmotm-2019-04-02-17-16_patched/tools/power/x86/turbostat/turbostat.c
> > index c7727be..17b1f544 100644
> > --- v5.1-rc3-mmotm-2019-04-02-17-16/tools/power/x86/turbostat/turbostat.c
> > +++ v5.1-rc3-mmotm-2019-04-02-17-16_patched/tools/power/x86/turbostat/turbostat.c
> > @@ -861,7 +861,6 @@ int dump_counters(struct thread_data *t, struct core_data *c,
> >  		outp += sprintf(outp, "pc8: %016llX\n", p->pc8);
> >  		outp += sprintf(outp, "pc9: %016llX\n", p->pc9);
> >  		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
> > -		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
> >  		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
> >  		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
> >  		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
> > @@ -5135,7 +5134,7 @@ int initialize_counters(int cpu_id)
> >  
> >  void allocate_output_buffer()
> >  {
> > -	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
> > +	output_buffer = calloc(1, (1 + topo.num_cpus) * 2048);
> 
> Is there a better way to calculate the size of that buffer other than a magic
> number?

Straightforward way to calculate it is to define the list of printing items
and set needed buffer size for each one, then sum them up in initialization.
But that might make code hard to maintain because we already have many small
items and they are not in common format.

Another approach independent of magic number or fixed-sized buffer is to
extend the buffer with remalloc() when we are approaching the end.
I hope the following patch might help.

# This patch is relatively large (~400 lines) but most are simple replacement
# of "sprintf(outp, ...)" with "append_to_output_buffer()".

Thanks,
Naoya Horiguchi
----------------------------------------------------------------------
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Thu, 4 Apr 2019 11:54:28 +0900
Subject: [PATCH] tools/power: turbostat: make output buffer extensible

"turbostat --Dump" could be terminated by general protection fault on
some latest hardwares which (for example) support 9 levels of C-states
and show 18 "tADDED" lines. That bloats the total output and finally
causes buffer overrun.  So this patch sugguests to extend the output
buffer when reaching the end.

This patch also removes duplicated "pc10:" line to reduce buffer usage.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 tools/power/x86/turbostat/turbostat.c | 397 ++++++++++++++------------
 1 file changed, 210 insertions(+), 187 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c7727be9719f..41d41c532a3e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -84,6 +84,7 @@ double tsc_tweak = 1.0;
 unsigned int show_pkg_only;
 unsigned int show_core_only;
 char *output_buffer, *outp;
+ssize_t outbuf_size;
 unsigned int do_rapl;
 unsigned int do_dts;
 unsigned int do_ptm;
@@ -625,6 +626,28 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
 	return retval;
 }
 
+static void *append_to_output_buffer(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	outp += vsprintf(outp, fmt, args);
+
+	/* Approaching the buffer end, so extend it. */
+	if (outp - output_buffer >= (outbuf_size - 256)) {
+		int output_size = outp - output_buffer;
+
+		outbuf_size += 1024;
+		output_buffer = realloc(output_buffer, outbuf_size);
+		if (output_buffer == NULL)
+			err(-1, "realloc output buffer");
+		if (debug)
+			printf("Output buffer was extended.\n");
+		outp = output_buffer + output_size;
+	}
+	va_end(args);
+	return outp;
+}
 
 void print_header(char *delim)
 {
@@ -632,173 +655,173 @@ void print_header(char *delim)
 	int printed = 0;
 
 	if (DO_BIC(BIC_USEC))
-		outp += sprintf(outp, "%susec", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%susec", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_TOD))
-		outp += sprintf(outp, "%sTime_Of_Day_Seconds", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sTime_Of_Day_Seconds", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Package))
-		outp += sprintf(outp, "%sPackage", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPackage", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Die))
-		outp += sprintf(outp, "%sDie", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sDie", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Node))
-		outp += sprintf(outp, "%sNode", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sNode", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Core))
-		outp += sprintf(outp, "%sCore", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCore", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU))
-		outp += sprintf(outp, "%sCPU", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCPU", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_APIC))
-		outp += sprintf(outp, "%sAPIC", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sAPIC", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_X2APIC))
-		outp += sprintf(outp, "%sX2APIC", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sX2APIC", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Avg_MHz))
-		outp += sprintf(outp, "%sAvg_MHz", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sAvg_MHz", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Busy))
-		outp += sprintf(outp, "%sBusy%%", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sBusy%%", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Bzy_MHz))
-		outp += sprintf(outp, "%sBzy_MHz", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sBzy_MHz", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_TSC_MHz))
-		outp += sprintf(outp, "%sTSC_MHz", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sTSC_MHz", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_IRQ)) {
 		if (sums_need_wide_columns)
-			outp += sprintf(outp, "%s     IRQ", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s     IRQ", (printed++ ? delim : ""));
 		else
-			outp += sprintf(outp, "%sIRQ", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sIRQ", (printed++ ? delim : ""));
 	}
 
 	if (DO_BIC(BIC_SMI))
-		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sSMI", (printed++ ? delim : ""));
 
 	for (mp = sys.tp; mp; mp = mp->next) {
 
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), mp->name);
+				outp = append_to_output_buffer("%s%18.18s", (printed++ ? delim : ""), mp->name);
 			else
-				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), mp->name);
+				outp = append_to_output_buffer("%s%10.10s", (printed++ ? delim : ""), mp->name);
 		} else {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), mp->name);
+				outp = append_to_output_buffer("%s%8s", (printed++ ? delim : ""), mp->name);
 			else
-				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), mp->name);
+				outp = append_to_output_buffer("%s%s", (printed++ ? delim : ""), mp->name);
 		}
 	}
 
 	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "%sCPU%%c1", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCPU%%c1", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_c3))
-		outp += sprintf(outp, "%sCPU%%c3", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCPU%%c3", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_c6))
-		outp += sprintf(outp, "%sCPU%%c6", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCPU%%c6", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_c7))
-		outp += sprintf(outp, "%sCPU%%c7", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCPU%%c7", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_Mod_c6))
-		outp += sprintf(outp, "%sMod%%c6", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sMod%%c6", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_CoreTmp))
-		outp += sprintf(outp, "%sCoreTmp", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCoreTmp", (printed++ ? delim : ""));
 
 	if (do_rapl && !rapl_joules) {
 		if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
-			outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sCorWatt", (printed++ ? delim : ""));
 	} else if (do_rapl && rapl_joules) {
 		if (DO_BIC(BIC_Cor_J) && (do_rapl & RAPL_PER_CORE_ENERGY))
-			outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sCor_J", (printed++ ? delim : ""));
 	}
 
 	for (mp = sys.cp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
+				outp = append_to_output_buffer("%s%18.18s", delim, mp->name);
 			else
-				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
+				outp = append_to_output_buffer("%s%10.10s", delim, mp->name);
 		} else {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", delim, mp->name);
+				outp = append_to_output_buffer("%s%8s", delim, mp->name);
 			else
-				outp += sprintf(outp, "%s%s", delim, mp->name);
+				outp = append_to_output_buffer("%s%s", delim, mp->name);
 		}
 	}
 
 	if (DO_BIC(BIC_PkgTmp))
-		outp += sprintf(outp, "%sPkgTmp", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPkgTmp", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_GFX_rc6))
-		outp += sprintf(outp, "%sGFX%%rc6", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sGFX%%rc6", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_GFXMHz))
-		outp += sprintf(outp, "%sGFXMHz", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sGFXMHz", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_Totl_c0))
-		outp += sprintf(outp, "%sTotl%%C0", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sTotl%%C0", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Any_c0))
-		outp += sprintf(outp, "%sAny%%C0", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sAny%%C0", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_GFX_c0))
-		outp += sprintf(outp, "%sGFX%%C0", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sGFX%%C0", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPUGFX))
-		outp += sprintf(outp, "%sCPUGFX%%", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCPUGFX%%", (printed++ ? delim : ""));
 
 	if (DO_BIC(BIC_Pkgpc2))
-		outp += sprintf(outp, "%sPkg%%pc2", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPkg%%pc2", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc3))
-		outp += sprintf(outp, "%sPkg%%pc3", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPkg%%pc3", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc6))
-		outp += sprintf(outp, "%sPkg%%pc6", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPkg%%pc6", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc7))
-		outp += sprintf(outp, "%sPkg%%pc7", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPkg%%pc7", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc8))
-		outp += sprintf(outp, "%sPkg%%pc8", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPkg%%pc8", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc9))
-		outp += sprintf(outp, "%sPkg%%pc9", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPkg%%pc9", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Pkgpc10))
-		outp += sprintf(outp, "%sPk%%pc10", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sPk%%pc10", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_CPU_LPI))
-		outp += sprintf(outp, "%sCPU%%LPI", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sCPU%%LPI", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_SYS_LPI))
-		outp += sprintf(outp, "%sSYS%%LPI", (printed++ ? delim : ""));
+		outp = append_to_output_buffer("%sSYS%%LPI", (printed++ ? delim : ""));
 
 	if (do_rapl && !rapl_joules) {
 		if (DO_BIC(BIC_PkgWatt))
-			outp += sprintf(outp, "%sPkgWatt", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sPkgWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
-			outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sCorWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_GFXWatt))
-			outp += sprintf(outp, "%sGFXWatt", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sGFXWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAMWatt))
-			outp += sprintf(outp, "%sRAMWatt", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sRAMWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_PKG__))
-			outp += sprintf(outp, "%sPKG_%%", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sPKG_%%", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAM__))
-			outp += sprintf(outp, "%sRAM_%%", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sRAM_%%", (printed++ ? delim : ""));
 	} else if (do_rapl && rapl_joules) {
 		if (DO_BIC(BIC_Pkg_J))
-			outp += sprintf(outp, "%sPkg_J", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sPkg_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Cor_J) && !(do_rapl & RAPL_PER_CORE_ENERGY))
-			outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sCor_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_GFX_J))
-			outp += sprintf(outp, "%sGFX_J", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sGFX_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAM_J))
-			outp += sprintf(outp, "%sRAM_J", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sRAM_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_PKG__))
-			outp += sprintf(outp, "%sPKG_%%", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sPKG_%%", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_RAM__))
-			outp += sprintf(outp, "%sRAM_%%", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%sRAM_%%", (printed++ ? delim : ""));
 	}
 	for (mp = sys.pp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
+				outp = append_to_output_buffer("%s%18.18s", delim, mp->name);
 			else
-				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
+				outp = append_to_output_buffer("%s%10.10s", delim, mp->name);
 		} else {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", delim, mp->name);
+				outp = append_to_output_buffer("%s%8s", delim, mp->name);
 			else
-				outp += sprintf(outp, "%s%s", delim, mp->name);
+				outp = append_to_output_buffer("%s%s", delim, mp->name);
 		}
 	}
 
-	outp += sprintf(outp, "\n");
+	outp = append_to_output_buffer("\n");
 }
 
 int dump_counters(struct thread_data *t, struct core_data *c,
@@ -807,80 +830,79 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 	int i;
 	struct msr_counter *mp;
 
-	outp += sprintf(outp, "t %p, c %p, p %p\n", t, c, p);
+	outp = append_to_output_buffer("t %p, c %p, p %p\n", t, c, p);
 
 	if (t) {
-		outp += sprintf(outp, "CPU: %d flags 0x%x\n",
+		outp = append_to_output_buffer("CPU: %d flags 0x%x\n",
 			t->cpu_id, t->flags);
-		outp += sprintf(outp, "TSC: %016llX\n", t->tsc);
-		outp += sprintf(outp, "aperf: %016llX\n", t->aperf);
-		outp += sprintf(outp, "mperf: %016llX\n", t->mperf);
-		outp += sprintf(outp, "c1: %016llX\n", t->c1);
+		outp = append_to_output_buffer("TSC: %016llX\n", t->tsc);
+		outp = append_to_output_buffer("aperf: %016llX\n", t->aperf);
+		outp = append_to_output_buffer("mperf: %016llX\n", t->mperf);
+		outp = append_to_output_buffer("c1: %016llX\n", t->c1);
 
 		if (DO_BIC(BIC_IRQ))
-			outp += sprintf(outp, "IRQ: %lld\n", t->irq_count);
+			outp = append_to_output_buffer("IRQ: %lld\n", t->irq_count);
 		if (DO_BIC(BIC_SMI))
-			outp += sprintf(outp, "SMI: %d\n", t->smi_count);
+			outp = append_to_output_buffer("SMI: %d\n", t->smi_count);
 
 		for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
-			outp += sprintf(outp, "tADDED [%d] msr0x%x: %08llX\n",
+			outp = append_to_output_buffer("tADDED [%d] msr0x%x: %08llX\n",
 				i, mp->msr_num, t->counter[i]);
 		}
 	}
 
 	if (c) {
-		outp += sprintf(outp, "core: %d\n", c->core_id);
-		outp += sprintf(outp, "c3: %016llX\n", c->c3);
-		outp += sprintf(outp, "c6: %016llX\n", c->c6);
-		outp += sprintf(outp, "c7: %016llX\n", c->c7);
-		outp += sprintf(outp, "DTS: %dC\n", c->core_temp_c);
-		outp += sprintf(outp, "Joules: %0X\n", c->core_energy);
+		outp = append_to_output_buffer("core: %d\n", c->core_id);
+		outp = append_to_output_buffer("c3: %016llX\n", c->c3);
+		outp = append_to_output_buffer("c6: %016llX\n", c->c6);
+		outp = append_to_output_buffer("c7: %016llX\n", c->c7);
+		outp = append_to_output_buffer("DTS: %dC\n", c->core_temp_c);
+		outp = append_to_output_buffer("Joules: %0X\n", c->core_energy);
 
 		for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
-			outp += sprintf(outp, "cADDED [%d] msr0x%x: %08llX\n",
+			outp = append_to_output_buffer("cADDED [%d] msr0x%x: %08llX\n",
 				i, mp->msr_num, c->counter[i]);
 		}
-		outp += sprintf(outp, "mc6_us: %016llX\n", c->mc6_us);
+		outp = append_to_output_buffer("mc6_us: %016llX\n", c->mc6_us);
 	}
 
 	if (p) {
-		outp += sprintf(outp, "package: %d\n", p->package_id);
+		outp = append_to_output_buffer("package: %d\n", p->package_id);
 
-		outp += sprintf(outp, "Weighted cores: %016llX\n", p->pkg_wtd_core_c0);
-		outp += sprintf(outp, "Any cores: %016llX\n", p->pkg_any_core_c0);
-		outp += sprintf(outp, "Any GFX: %016llX\n", p->pkg_any_gfxe_c0);
-		outp += sprintf(outp, "CPU + GFX: %016llX\n", p->pkg_both_core_gfxe_c0);
+		outp = append_to_output_buffer("Weighted cores: %016llX\n", p->pkg_wtd_core_c0);
+		outp = append_to_output_buffer("Any cores: %016llX\n", p->pkg_any_core_c0);
+		outp = append_to_output_buffer("Any GFX: %016llX\n", p->pkg_any_gfxe_c0);
+		outp = append_to_output_buffer("CPU + GFX: %016llX\n", p->pkg_both_core_gfxe_c0);
 
-		outp += sprintf(outp, "pc2: %016llX\n", p->pc2);
+		outp = append_to_output_buffer("pc2: %016llX\n", p->pc2);
 		if (DO_BIC(BIC_Pkgpc3))
-			outp += sprintf(outp, "pc3: %016llX\n", p->pc3);
+			outp = append_to_output_buffer("pc3: %016llX\n", p->pc3);
 		if (DO_BIC(BIC_Pkgpc6))
-			outp += sprintf(outp, "pc6: %016llX\n", p->pc6);
+			outp = append_to_output_buffer("pc6: %016llX\n", p->pc6);
 		if (DO_BIC(BIC_Pkgpc7))
-			outp += sprintf(outp, "pc7: %016llX\n", p->pc7);
-		outp += sprintf(outp, "pc8: %016llX\n", p->pc8);
-		outp += sprintf(outp, "pc9: %016llX\n", p->pc9);
-		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
-		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
-		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
-		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
-		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
-		outp += sprintf(outp, "Joules COR: %0X\n", p->energy_cores);
-		outp += sprintf(outp, "Joules GFX: %0X\n", p->energy_gfx);
-		outp += sprintf(outp, "Joules RAM: %0X\n", p->energy_dram);
-		outp += sprintf(outp, "Throttle PKG: %0X\n",
+			outp = append_to_output_buffer("pc7: %016llX\n", p->pc7);
+		outp = append_to_output_buffer("pc8: %016llX\n", p->pc8);
+		outp = append_to_output_buffer("pc9: %016llX\n", p->pc9);
+		outp = append_to_output_buffer("pc10: %016llX\n", p->pc10);
+		outp = append_to_output_buffer("cpu_lpi: %016llX\n", p->cpu_lpi);
+		outp = append_to_output_buffer("sys_lpi: %016llX\n", p->sys_lpi);
+		outp = append_to_output_buffer("Joules PKG: %0X\n", p->energy_pkg);
+		outp = append_to_output_buffer("Joules COR: %0X\n", p->energy_cores);
+		outp = append_to_output_buffer("Joules GFX: %0X\n", p->energy_gfx);
+		outp = append_to_output_buffer("Joules RAM: %0X\n", p->energy_dram);
+		outp = append_to_output_buffer("Throttle PKG: %0X\n",
 			p->rapl_pkg_perf_status);
-		outp += sprintf(outp, "Throttle RAM: %0X\n",
+		outp = append_to_output_buffer("Throttle RAM: %0X\n",
 			p->rapl_dram_perf_status);
-		outp += sprintf(outp, "PTM: %dC\n", p->pkg_temp_c);
+		outp = append_to_output_buffer("PTM: %dC\n", p->pkg_temp_c);
 
 		for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-			outp += sprintf(outp, "pADDED [%d] msr0x%x: %08llX\n",
+			outp = append_to_output_buffer("pADDED [%d] msr0x%x: %08llX\n",
 				i, mp->msr_num, p->counter[i]);
 		}
 	}
 
-	outp += sprintf(outp, "\n");
+	outp = append_to_output_buffer("\n");
 
 	return 0;
 }
@@ -916,12 +938,12 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		struct timeval tv;
 
 		timersub(&t->tv_end, &t->tv_begin, &tv);
-		outp += sprintf(outp, "%5ld\t", tv.tv_sec * 1000000 + tv.tv_usec);
+		outp = append_to_output_buffer("%5ld\t", tv.tv_sec * 1000000 + tv.tv_usec);
 	}
 
 	/* Time_Of_Day_Seconds: on each row, print sec.usec last timestamp taken */
 	if (DO_BIC(BIC_TOD))
-		outp += sprintf(outp, "%10ld.%06ld\t", t->tv_end.tv_sec, t->tv_end.tv_usec);
+		outp = append_to_output_buffer("%10ld.%06ld\t", t->tv_end.tv_sec, t->tv_end.tv_usec);
 
 	interval_float = tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;
 
@@ -930,108 +952,108 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	/* topo columns, print blanks on 1st (average) line */
 	if (t == &average.threads) {
 		if (DO_BIC(BIC_Package))
-			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Die))
-			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Node))
-			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_Core))
-			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_CPU))
-			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_APIC))
-			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_X2APIC))
-			outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 	} else {
 		if (DO_BIC(BIC_Package)) {
 			if (p)
-				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->package_id);
+				outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), p->package_id);
 			else
-				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+				outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		}
 		if (DO_BIC(BIC_Die)) {
 			if (c)
-				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), cpus[t->cpu_id].die_id);
+				outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), cpus[t->cpu_id].die_id);
 			else
-				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+				outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		}
 		if (DO_BIC(BIC_Node)) {
 			if (t)
-				outp += sprintf(outp, "%s%d",
+				outp = append_to_output_buffer("%s%d",
 						(printed++ ? delim : ""),
 					      cpus[t->cpu_id].physical_node_id);
 			else
-				outp += sprintf(outp, "%s-",
+				outp = append_to_output_buffer("%s-",
 						(printed++ ? delim : ""));
 		}
 		if (DO_BIC(BIC_Core)) {
 			if (c)
-				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_id);
+				outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), c->core_id);
 			else
-				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
+				outp = append_to_output_buffer("%s-", (printed++ ? delim : ""));
 		}
 		if (DO_BIC(BIC_CPU))
-			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->cpu_id);
+			outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), t->cpu_id);
 		if (DO_BIC(BIC_APIC))
-			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->apic_id);
+			outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), t->apic_id);
 		if (DO_BIC(BIC_X2APIC))
-			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->x2apic_id);
+			outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), t->x2apic_id);
 	}
 
 	if (DO_BIC(BIC_Avg_MHz))
-		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""),
+		outp = append_to_output_buffer("%s%.0f", (printed++ ? delim : ""),
 			1.0 / units * t->aperf / interval_float);
 
 	if (DO_BIC(BIC_Busy))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->mperf/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * t->mperf/tsc);
 
 	if (DO_BIC(BIC_Bzy_MHz)) {
 		if (has_base_hz)
-			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), base_hz / units * t->aperf / t->mperf);
+			outp = append_to_output_buffer("%s%.0f", (printed++ ? delim : ""), base_hz / units * t->aperf / t->mperf);
 		else
-			outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""),
+			outp = append_to_output_buffer("%s%.0f", (printed++ ? delim : ""),
 				tsc / units * t->aperf / t->mperf / interval_float);
 	}
 
 	if (DO_BIC(BIC_TSC_MHz))
-		outp += sprintf(outp, "%s%.0f", (printed++ ? delim : ""), 1.0 * t->tsc/units/interval_float);
+		outp = append_to_output_buffer("%s%.0f", (printed++ ? delim : ""), 1.0 * t->tsc/units/interval_float);
 
 	/* IRQ */
 	if (DO_BIC(BIC_IRQ)) {
 		if (sums_need_wide_columns)
-			outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->irq_count);
+			outp = append_to_output_buffer("%s%8lld", (printed++ ? delim : ""), t->irq_count);
 		else
-			outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->irq_count);
+			outp = append_to_output_buffer("%s%lld", (printed++ ? delim : ""), t->irq_count);
 	}
 
 	/* SMI */
 	if (DO_BIC(BIC_SMI))
-		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), t->smi_count);
+		outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), t->smi_count);
 
 	/* Added counters */
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) t->counter[i]);
+				outp = append_to_output_buffer("%s0x%08x", (printed++ ? delim : ""), (unsigned int) t->counter[i]);
 			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
+				outp = append_to_output_buffer("%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), t->counter[i]);
+				outp = append_to_output_buffer("%s%8lld", (printed++ ? delim : ""), t->counter[i]);
 			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), t->counter[i]);
+				outp = append_to_output_buffer("%s%lld", (printed++ ? delim : ""), t->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
 			if (mp->type == COUNTER_USEC)
-				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), t->counter[i]/interval_float/10000);
+				outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), t->counter[i]/interval_float/10000);
 			else
-				outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->counter[i]/tsc);
+				outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * t->counter[i]/tsc);
 		}
 	}
 
 	/* C1 */
 	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * t->c1/tsc);
 
 
 	/* print per-core data only for 1st thread in core */
@@ -1039,32 +1061,32 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		goto done;
 
 	if (DO_BIC(BIC_CPU_c3))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c3/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * c->c3/tsc);
 	if (DO_BIC(BIC_CPU_c6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c6/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * c->c6/tsc);
 	if (DO_BIC(BIC_CPU_c7))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->c7/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * c->c7/tsc);
 
 	/* Mod%c6 */
 	if (DO_BIC(BIC_Mod_c6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->mc6_us / tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * c->mc6_us / tsc);
 
 	if (DO_BIC(BIC_CoreTmp))
-		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_temp_c);
+		outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), c->core_temp_c);
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) c->counter[i]);
+				outp = append_to_output_buffer("%s0x%08x", (printed++ ? delim : ""), (unsigned int) c->counter[i]);
 			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
+				outp = append_to_output_buffer("%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), c->counter[i]);
+				outp = append_to_output_buffer("%s%8lld", (printed++ ? delim : ""), c->counter[i]);
 			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), c->counter[i]);
+				outp = append_to_output_buffer("%s%lld", (printed++ ? delim : ""), c->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * c->counter[i]/tsc);
+			outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * c->counter[i]/tsc);
 		}
 	}
 
@@ -1078,9 +1100,9 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		fmt8 = "%6.0f**";
 
 	if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units / interval_float);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units / interval_float);
 	if (DO_BIC(BIC_Cor_J) && (do_rapl & RAPL_PER_CORE_ENERGY))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units);
 
 	/* print per-package data only for 1st core in package */
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
@@ -1088,92 +1110,92 @@ int format_counters(struct thread_data *t, struct core_data *c,
 
 	/* PkgTmp */
 	if (DO_BIC(BIC_PkgTmp))
-		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->pkg_temp_c);
+		outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), p->pkg_temp_c);
 
 	/* GFXrc6 */
 	if (DO_BIC(BIC_GFX_rc6)) {
 		if (p->gfx_rc6_ms == -1) {	/* detect GFX counter reset */
-			outp += sprintf(outp, "%s**.**", (printed++ ? delim : ""));
+			outp = append_to_output_buffer("%s**.**", (printed++ ? delim : ""));
 		} else {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
+			outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""),
 				p->gfx_rc6_ms / 10.0 / interval_float);
 		}
 	}
 
 	/* GFXMHz */
 	if (DO_BIC(BIC_GFXMHz))
-		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->gfx_mhz);
+		outp = append_to_output_buffer("%s%d", (printed++ ? delim : ""), p->gfx_mhz);
 
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
 	if (DO_BIC(BIC_Totl_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0/tsc);
 	if (DO_BIC(BIC_Any_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_core_c0/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_core_c0/tsc);
 	if (DO_BIC(BIC_GFX_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_gfxe_c0/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_any_gfxe_c0/tsc);
 	if (DO_BIC(BIC_CPUGFX))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_both_core_gfxe_c0/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_both_core_gfxe_c0/tsc);
 
 	if (DO_BIC(BIC_Pkgpc2))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc2/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc2/tsc);
 	if (DO_BIC(BIC_Pkgpc3))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc3/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc3/tsc);
 	if (DO_BIC(BIC_Pkgpc6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc6/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc6/tsc);
 	if (DO_BIC(BIC_Pkgpc7))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc7/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc7/tsc);
 	if (DO_BIC(BIC_Pkgpc8))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc8/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc8/tsc);
 	if (DO_BIC(BIC_Pkgpc9))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc9/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc9/tsc);
 	if (DO_BIC(BIC_Pkgpc10))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10/tsc);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10/tsc);
 
 	if (DO_BIC(BIC_CPU_LPI))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->cpu_lpi / 1000000.0 / interval_float);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->cpu_lpi / 1000000.0 / interval_float);
 	if (DO_BIC(BIC_SYS_LPI))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->sys_lpi / 1000000.0 / interval_float);
+		outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->sys_lpi / 1000000.0 / interval_float);
 
 	if (DO_BIC(BIC_PkgWatt))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
 	if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
 	if (DO_BIC(BIC_GFXWatt))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units / interval_float);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units / interval_float);
 	if (DO_BIC(BIC_RAMWatt))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units / interval_float);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units / interval_float);
 	if (DO_BIC(BIC_Pkg_J))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units);
 	if (DO_BIC(BIC_Cor_J) && !(do_rapl & RAPL_PER_CORE_ENERGY))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units);
 	if (DO_BIC(BIC_GFX_J))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units);
 	if (DO_BIC(BIC_RAM_J))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units);
 	if (DO_BIC(BIC_PKG__))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
 	if (DO_BIC(BIC_RAM__))
-		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
+		outp = append_to_output_buffer(fmt8, (printed++ ? delim : ""), 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) p->counter[i]);
+				outp = append_to_output_buffer("%s0x%08x", (printed++ ? delim : ""), (unsigned int) p->counter[i]);
 			else
-				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->counter[i]);
+				outp = append_to_output_buffer("%s0x%016llx", (printed++ ? delim : ""), p->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8lld", (printed++ ? delim : ""), p->counter[i]);
+				outp = append_to_output_buffer("%s%8lld", (printed++ ? delim : ""), p->counter[i]);
 			else
-				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), p->counter[i]);
+				outp = append_to_output_buffer("%s%lld", (printed++ ? delim : ""), p->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->counter[i]/tsc);
+			outp = append_to_output_buffer("%s%.2f", (printed++ ? delim : ""), 100.0 * p->counter[i]/tsc);
 		}
 	}
 
 done:
 	if (*(outp - 1) != '\n')
-		outp += sprintf(outp, "\n");
+		outp = append_to_output_buffer("\n");
 
 	return 0;
 }
@@ -5135,7 +5157,8 @@ int initialize_counters(int cpu_id)
 
 void allocate_output_buffer()
 {
-	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
+	outbuf_size = (1 + topo.num_cpus) * 1024;
+	output_buffer = calloc(1, outbuf_size);
 	outp = output_buffer;
 	if (outp == NULL)
 		err(-1, "calloc output buffer");
-- 
2.17.1

