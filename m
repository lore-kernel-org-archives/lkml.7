Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3AFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F921929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392226AbfJYDlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:41:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58145 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfJYDlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:41:11 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iNqTK-0000Sf-29; Thu, 24 Oct 2019 21:41:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iNqTI-0008Bt-5E; Thu, 24 Oct 2019 21:41:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     lijiang <lijiang@redhat.com>
Cc:     "d.hatayama\@fujitsu.com" <d.hatayama@fujitsu.com>,
        Simon Horman <horms@verge.net.au>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross\@suse.com" <jgross@suse.com>,
        "Thomas.Lendacky\@amd.com" <Thomas.Lendacky@amd.com>,
        "bhe\@redhat.com" <bhe@redhat.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "kexec\@lists.infradead.org" <kexec@lists.infradead.org>,
        "dhowells\@redhat.com" <dhowells@redhat.com>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "dyoung\@redhat.com" <dyoung@redhat.com>,
        "vgoyal\@redhat.com" <vgoyal@redhat.com>
References: <20191023141912.29110-1-lijiang@redhat.com>
        <20191023141912.29110-2-lijiang@redhat.com>
        <20191024100719.GC11441@verge.net.au>
        <4c1c4b78-23f0-a2b9-4be7-5bab0335f10a@redhat.com>
        <6da13645-c5e9-6c95-1f2d-bede177f9863@redhat.com>
        <OSBPR01MB40062E08DFAEDA628FDC945895650@OSBPR01MB4006.jpnprd01.prod.outlook.com>
        <2020bbf9-67b2-52e8-756f-b595414b4c02@redhat.com>
Date:   Thu, 24 Oct 2019 22:39:59 -0500
In-Reply-To: <2020bbf9-67b2-52e8-756f-b595414b4c02@redhat.com> (lijiang's
        message of "Fri, 25 Oct 2019 11:14:43 +0800")
Message-ID: <875zkdtrw0.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iNqTI-0008Bt-5E;;;mid=<875zkdtrw0.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++EmeJ2BIKf+/UnCiscXCiWx8rDM8yULM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2 v5] x86/kdump: always reserve the low 1MiB when the crashkernel option is specified
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lijiang <lijiang@redhat.com> writes:

>  * Returns the length of the argument (regardless of if it was
>  * truncated to fit in the buffer), or -1 on not found.
>  */
> static int
> __cmdline_find_option(const char *cmdline, int max_cmdline_size,
>                       const char *option, char *buffer, int bufsize)
>
>
> According to the above code comment, it should be better like this:
>
> +       if (cmdline_find_option(boot_command_line, "crashkernel",
> +                               NULL, 0) > 0) {
>
> After i test, i will post again.
>

This seems reasonable as we are dealing with x86 only code.

It wound be nice if someone could generalize cmdline_find_option to be
arch independent so that crash_core.c:parse_crashkernel could use it.
I don't think for this patchset, but it looks like an overdue cleanup.

We run the risk with parse_crashkernel using strstr and this using
another algorithm of having different kernel command line parsers
giving different results and disagreeing if "crashkernel=" is present
or not on the kernel command line.

Eric


