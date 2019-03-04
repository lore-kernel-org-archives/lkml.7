Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C5EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE23E20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfCDOsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfCDOse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:48:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB08C307D874;
        Mon,  4 Mar 2019 14:48:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6341827C25;
        Mon,  4 Mar 2019 14:48:33 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:48:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 02/11] perf tools script: Support insn output for
 normal samples
Message-ID: <20190304144832.GI30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-3-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 04 Mar 2019 14:48:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:41AM -0800, Andi Kleen wrote:

SNIP

> @@ -1234,9 +1243,12 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  {
>  	int printed = 0;
>  
> +	if (sample->insn_len == 0 && native_arch)
> +		arch_fetch_insn(sample, thread, machine);
> +
>  	if (PRINT_FIELD(INSNLEN))
>  		printed += fprintf(fp, " ilen: %d", sample->insn_len);
> -	if (PRINT_FIELD(INSN)) {
> +	if (PRINT_FIELD(INSN) && sample->insn_len) {
>  		int i;
>  
>  		printed += fprintf(fp, " insn:");
> @@ -3277,6 +3289,7 @@ int cmd_script(int argc, const char **argv)
>  		.set = false,
>  		.default_no_sample = true,
>  	};
> +	struct utsname uts;
>  	char *script_path = NULL;
>  	const char **__argv;
>  	int i, j, err = 0;
> @@ -3615,6 +3628,12 @@ int cmd_script(int argc, const char **argv)
>  	if (symbol__init(&session->header.env) < 0)
>  		goto out_delete;
>  
> +	uname(&uts);
> +	if (!strcmp(uts.machine, session->header.env.arch) ||
> +		(!strcmp(uts.machine, "x86_64") &&
> +		 !strcmp(session->header.env.arch, "i386")))

why is this check and native_arch bool necessary?
i386 data will be overed by arch/x86

jirka
