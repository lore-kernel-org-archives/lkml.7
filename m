Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F03C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F632168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfFNN6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:58:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:39583 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfFNN6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:58:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 06:57:59 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2019 06:57:57 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 05/14] scripts: add an script to parse the ABI files
In-Reply-To: <20190614133933.GA1076@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1560477540.git.mchehab+samsung@kernel.org> <196fb3c497546f923bf5d156c3fddbe74a4913bc.1560477540.git.mchehab+samsung@kernel.org> <87r27wuwc3.fsf@intel.com> <20190614133933.GA1076@kroah.com>
Date:   Fri, 14 Jun 2019 17:00:55 +0300
Message-ID: <87lfy4uuzs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Fri, Jun 14, 2019 at 04:31:56PM +0300, Jani Nikula wrote:
>> On Thu, 13 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>> > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>> >
>> > Add a script to parse the Documentation/ABI files and produce
>> > an output with all entries inside an ABI (sub)directory.
>> >
>> > Right now, it outputs its contents on ReST format. It shouldn't
>> > be hard to make it produce other kind of outputs, since the ABI
>> > file parser is implemented in separate than the output generator.
>> 
>> Hum, or just convert the ABI files to rst directly.
>
> And what would that look like?

That pretty much depends on the requirements we want to set on both the
ABI source files and the generated output. Obviously the requirements
can be conflicting; might be hard to produce fancy output if the input
is very limited.

At the bare minimum, you could convert the files to contain
reStructuredText field lists [1]. Add a colon at the start of the field
name, and make sure field bodies (values) are not empty.

Conversion of a file selected at random; I've only added ":" and "N/A".

diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentation/ABI/stable/sysfs-devices-system-cpu
index 33c133e2a631..34c218b344fb 100644
--- a/Documentation/ABI/stable/sysfs-devices-system-cpu
+++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
@@ -1,19 +1,20 @@
-What: 		/sys/devices/system/cpu/dscr_default
-Date:		13-May-2014
-KernelVersion:	v3.15.0
-Contact:
-Description:	Writes are equivalent to writing to
+:What: 		/sys/devices/system/cpu/dscr_default
+:Date:		13-May-2014
+:KernelVersion:	v3.15.0
+:Contact:	N/A
+:Description:	Writes are equivalent to writing to
 		/sys/devices/system/cpu/cpuN/dscr on all CPUs.
 		Reads return the last written value or 0.
 		This value is not a global default: it is a way to set
 		all per-CPU defaults at the same time.
-Values:		64 bit unsigned integer (bit field)
+:Values:	64 bit unsigned integer (bit field)
 
-What: 		/sys/devices/system/cpu/cpu[0-9]+/dscr
-Date:		13-May-2014
-KernelVersion:	v3.15.0
-Contact:
-Description:	Default value for the Data Stream Control Register (DSCR) on
+
+:What: 		/sys/devices/system/cpu/cpu[0-9]+/dscr
+:Date:		13-May-2014
+:KernelVersion:	v3.15.0
+:Contact:	N/A
+:Description:	Default value for the Data Stream Control Register (DSCR) on
 		a CPU.
 		This default value is used when the kernel is executing and
 		for any process that has not set the DSCR itself.
@@ -22,4 +23,4 @@ Description:	Default value for the Data Stream Control Register (DSCR) on
 		on any CPU where it executes (overriding the value described
 		here).
 		If set by a process it will be inherited by child processes.
-Values:		64 bit unsigned integer (bit field)
+:Values:		64 bit unsigned integer (bit field)

---

Of course, you'd still need to add higher level files to include the ABI
files.

At the other end, you could add structure and syntax to your heart's
content, and make the output fancier too.

BR,
Jani.

[1] http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#field-lists


-- 
Jani Nikula, Intel Open Source Graphics Center
