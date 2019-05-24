Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C117C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ABC21841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tss8Q+q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391282AbfEXLux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:50:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46473 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390743AbfEXLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:50:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so7005969qkb.13;
        Fri, 24 May 2019 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7PC/m0eDgpsq7W81Q60S/bQLLIxrYldmXlsCsWrp2jI=;
        b=Tss8Q+q3ESR0cP0PX2BXnEMI1mNeR7KGDLZF5PNhJXtrTkWJQqQmeN6G8K6bvQFYjM
         43ErzvC9pnOch8wxKMMW5bQKLrCeBY2H+DrA7glsz7ulvz7ZwmbvpzFgtIfrqbzmUz5J
         jOvAXpXlssCryPPRgw5VGtoAbSkQJDggtVKP05WZkfhiL6sM2TG/+8PnYS/pT6HZ2QyE
         tLbtNN0kLvCUmlUWZBmbyOz6+o8rWzDXTmbQ2IeIkezyYEP/2fMOqhgzsKawJnMYIRfu
         qk3OIUBSHAvOLAVj/1FDrT+m4+Fz9WMWs9echDRQLB3RcrjzJhfsXlzILj9yz9wjsop1
         +JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7PC/m0eDgpsq7W81Q60S/bQLLIxrYldmXlsCsWrp2jI=;
        b=SdG4lQLLknTnYPL6ZrurhEp5/5A/BLNHFIrkhLXU4F/xxOD4XvFeffChaljLL/eybr
         UT5ta0g/TY9WUmoqzJI7UDSfZucVMOcpiPAvkdcj1jZeNWt4ha8a6r+R7/O4OZpArGCG
         Tzyd9r0ce2wgkfeiqmWBWaCC8OI4XpVchiEvo0ppKQqKbSnUkrcF9EIrdbUSJ6IHIy63
         tnnhmnBtr9hA0p6GXblaD0UOKpmFBxDVozROTROjGrrRBWj5RIVUtsRutTlSTTfZOWeD
         TFScM3fkkHELj0xlSiWpc3CwjGEWd6w4W8kQPY2HLRF6zsizA8CAu85BaDIFYTnZQT1X
         mb8w==
X-Gm-Message-State: APjAAAUiV3OXZHv1g2xfPkTAjcei5oZNDnOjW08wFgcNNKFeUiERmjSA
        HdH/P53qew6SLjizIdTw1hk=
X-Google-Smtp-Source: APXvYqzkqxYR/UO7m+7nOo/3x/9X3WHfYmEMwSfRNqMbElu1gIFKeE5Hp1iJn6OHDSdDnyaglOOfHA==
X-Received: by 2002:ac8:414e:: with SMTP id e14mr41855428qtm.343.1558698651488;
        Fri, 24 May 2019 04:50:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id j62sm995390qte.89.2019.05.24.04.50.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 04:50:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E767641149; Fri, 24 May 2019 08:50:47 -0300 (-03)
Date:   Fri, 24 May 2019 08:50:47 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCHv2] perf/report: Support s390 diag event display on x86
Message-ID: <20190524115047.GB17479@kernel.org>
References: <20190522064325.25596-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522064325.25596-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 22, 2019 at 08:43:25AM +0200, Thomas Richter escreveu:
> Perf report fails to display s390 specific event numbered bd000
> on an x86 platform. For example on s390 this works without error:
> 
> [root@m35lp76 perf]# uname -m
> s390x
> [root@m35lp76 perf]# ./perf record -e rbd000 -- find / >/dev/null
> [ perf record: Woken up 3 times to write data ]
> [ perf record: Captured and wrote 0.549 MB perf.data ]
> [root@m35lp76 perf]# ./perf report -D --stdio  > /dev/null
> [root@m35lp76 perf]#
> 
> Transfering this perf.data file to an x86 platform and executing
> the same report command produces:
> 
> [root@f29 perf]# uname -m
> x86_64
> [root@f29 perf]# ./perf report -i ~/perf.data.m35lp76 --stdio
> interpreting bpf_prog_info from systems with endianity is not yet supported
> interpreting btf from systems with endianity is not yet supported
> 0x8c890 [0x8]: failed to process type: 68
> Error:
> failed to process sample
> 
> Event bd000 generates auxiliary data which is stored in big endian
> format in the perf data file.
> This error is caused by missing endianess handling on the x86 platform
> when the data is displayed. Fix this by handling s390 auxiliary event
> data depending on the local platform endianness.
> 
> Output after on x86:
> 
> [root@f29 perf]# ./perf report -D -i ~/perf.data.m35lp76 --stdio > /dev/null
> interpreting bpf_prog_info from systems with endianity is not yet supported
> interpreting btf from systems with endianity is not yet supported
> [root@f29 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/util/s390-cpumsf.c | 95 ++++++++++++++++++++++++++++-------
>  1 file changed, 77 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> index c215704931dc..884ac79528ff 100644
> --- a/tools/perf/util/s390-cpumsf.c
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -17,8 +17,8 @@
>   *	see Documentation/perf.data-file-format.txt.
>   * PERF_RECORD_AUXTRACE_INFO:
>   *	Defines a table of contains for PERF_RECORD_AUXTRACE records. This
> - *	record is generated during 'perf record' command. Each record contains up
> - *	to 256 entries describing offset and size of the AUXTRACE data in the
> + *	record is generated during 'perf record' command. Each record contains
> + *	up to 256 entries describing offset and size of the AUXTRACE data in the
>   *	perf.data file.
>   * PERF_RECORD_AUXTRACE_ERROR:
>   *	Indicates an error during AUXTRACE collection such as buffer overflow.
> @@ -237,10 +237,33 @@ static int s390_cpumcf_dumpctr(struct s390_cpumsf *sf,
>  	return rc;
>  }
>  
> -/* Display s390 CPU measurement facility basic-sampling data entry */
> +/* Display s390 CPU measurement facility basic-sampling data entry
> + * Data written on s390 in big endian byte order and contains bit
> + * fields across byte boundaries.
> + */
>  static bool s390_cpumsf_basic_show(const char *color, size_t pos,
> -				   struct hws_basic_entry *basic)
> +				   struct hws_basic_entry *basicp)
>  {
> +	struct hws_basic_entry *basic = basicp;
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +	struct hws_basic_entry local;
> +	unsigned long word = be64toh(*(unsigned long *)basicp);
> +
> +	memset(&local, 0, sizeof(local));
> +	local.def = be16toh(basicp->def);
> +	local.prim_asn = word & 0xffff;
> +	local.CL = word >> 30 & 0x3;
> +	local.I = word >> 32 & 0x1;
> +	local.AS = word >> 33 & 0x3;
> +	local.P = word >> 35 & 0x1;
> +	local.W = word >> 36 & 0x1;
> +	local.T = word >> 37 & 0x1;
> +	local.U = word >> 40 & 0xf;
> +	local.ia = be64toh(basicp->ia);
> +	local.gpp = be64toh(basicp->gpp);
> +	local.hpp = be64toh(basicp->hpp);
> +	basic = &local;
> +#endif
>  	if (basic->def != 1) {
>  		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
>  		return false;
> @@ -258,10 +281,22 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
>  	return true;
>  }
>  
> -/* Display s390 CPU measurement facility diagnostic-sampling data entry */
> +/* Display s390 CPU measurement facility diagnostic-sampling data entry.
> + * Data written on s390 in big endian byte order and contains bit
> + * fields across byte boundaries.
> + */
>  static bool s390_cpumsf_diag_show(const char *color, size_t pos,
> -				  struct hws_diag_entry *diag)
> +				  struct hws_diag_entry *diagp)
>  {
> +	struct hws_diag_entry *diag = diagp;
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +	struct hws_diag_entry local;
> +	unsigned long word = be64toh(*(unsigned long *)diagp);
> +
> +	local.def = be16toh(diagp->def);
> +	local.I = word >> 32 & 0x1;
> +	diag = &local;
> +#endif
>  	if (diag->def < S390_CPUMSF_DIAG_DEF_FIRST) {
>  		pr_err("Invalid AUX trace diagnostic entry [%#08zx]\n", pos);
>  		return false;
> @@ -272,35 +307,51 @@ static bool s390_cpumsf_diag_show(const char *color, size_t pos,
>  }
>  
>  /* Return TOD timestamp contained in an trailer entry */
> -static unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
> +static unsigned long long trailer_timestamp(struct hws_trailer_entry *te,
> +					    int idx)
>  {
>  	/* te->t set: TOD in STCKE format, bytes 8-15
>  	 * to->t not set: TOD in STCK format, bytes 0-7
>  	 */
>  	unsigned long long ts;
>  
> -	memcpy(&ts, &te->timestamp[te->t], sizeof(ts));
> -	return ts;
> +	memcpy(&ts, &te->timestamp[idx], sizeof(ts));
> +	return be64toh(ts);
>  }
>  
>  /* Display s390 CPU measurement facility trailer entry */
>  static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
>  				     struct hws_trailer_entry *te)
>  {
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +	struct hws_trailer_entry local;
> +
> +	memset(&local, 0, sizeof(local));
> +	local.f = be64toh(te->flags) >> 63 & 0x1;
> +	local.a = be64toh(te->flags) >> 62 & 0x1;
> +	local.t = be64toh(te->flags) >> 61 & 0x1;
> +	local.bsdes = be16toh((be64toh(te->flags) >> 16 & 0xffff));
> +	local.dsdes = be16toh((be64toh(te->flags) & 0xffff));
> +	memcpy(&local.timestamp, te->timestamp, sizeof(te->timestamp));
> +	local.overflow = be64toh(te->overflow);
> +	local.clock_base = be64toh(te->progusage[0]) >> 63 & 1;
> +	local.progusage2 = be64toh(te->progusage2);
> +	te = &local;

On centos:6, ubuntu:12.04.5:

  CC       /tmp/build/perf/util/help-unknown-cmd.o
cc1: warnings being treated as errors
util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':  MKDIR    /tmp/build/perf/util/

util/s390-cpumsf.c:333: error: declaration of '__v' shadows a previous local
util/s390-cpumsf.c:333: error: shadowed declaration is here
util/s390-cpumsf.c:333: error: declaration of '__x' shadows a previous local
util/s390-cpumsf.c:333: error: shadowed declaration is here
util/s390-cpumsf.c:334: error: declaration of '__v' shadows a previous local
util/s390-cpumsf.c:334: error: shadowed declaration is here
util/s390-cpumsf.c:334: error: declaration of '__x' shadows a previous local
util/s390-cpumsf.c:334: error: shadowed declaration is here
  CC       /tmp/build/perf/util/mem-events.o
mv: cannot stat `/tmp/build/perf/util/.s390-cpumsf.o.tmp': No such file or directory
make[4]: *** [/tmp/build/perf/util/s390-cpumsf.o] Error 1
make[4]: *** Waiting for unfinished jobs....

I'll try to figure this out later.

- Arnaldo


> +#endif
>  	if (te->bsdes != sizeof(struct hws_basic_entry)) {
>  		pr_err("Invalid AUX trace trailer entry [%#08zx]\n", pos);
>  		return false;
>  	}
>  	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
>  		      " dsdes:%d Overflow:%lld Time:%#llx\n"
> -		      "\t\tC:%d TOD:%#lx 1:%#llx 2:%#llx\n",
> +		      "\t\tC:%d TOD:%#lx\n",
>  		      pos,
>  		      te->f ? 'F' : ' ',
>  		      te->a ? 'A' : ' ',
>  		      te->t ? 'T' : ' ',
>  		      te->bsdes, te->dsdes, te->overflow,
> -		      trailer_timestamp(te), te->clock_base, te->progusage2,
> -		      te->progusage[0], te->progusage[1]);
> +		      trailer_timestamp(te, te->clock_base),
> +		      te->clock_base, te->progusage2);
>  	return true;
>  }
>  
> @@ -327,13 +378,13 @@ static bool s390_cpumsf_validate(int machine_type,
>  	*dsdes = *bsdes = 0;
>  	if (len & (S390_CPUMSF_PAGESZ - 1))	/* Illegal size */
>  		return false;
> -	if (basic->def != 1)		/* No basic set entry, must be first */
> +	if (be16toh(basic->def) != 1)	/* No basic set entry, must be first */
>  		return false;
>  	/* Check for trailer entry at end of SDB */
>  	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
>  					      - sizeof(*te));
> -	*bsdes = te->bsdes;
> -	*dsdes = te->dsdes;
> +	*bsdes = be16toh(te->bsdes);
> +	*dsdes = be16toh(te->dsdes);
>  	if (!te->bsdes && !te->dsdes) {
>  		/* Very old hardware, use CPUID */
>  		switch (machine_type) {
> @@ -495,19 +546,27 @@ static bool s390_cpumsf_make_event(size_t pos,
>  static unsigned long long get_trailer_time(const unsigned char *buf)
>  {
>  	struct hws_trailer_entry *te;
> -	unsigned long long aux_time;
> +	unsigned long long aux_time, progusage2;
> +	bool clock_base;
>  
>  	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
>  					      - sizeof(*te));
>  
> -	if (!te->clock_base)	/* TOD_CLOCK_BASE value missing */
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +	clock_base = be64toh(te->progusage[0]) >> 63 & 0x1;
> +	progusage2 = be64toh(te->progusage[1]);
> +#else
> +	clock_base = te->clock_base;
> +	progusage2 = te->progusage2;
> +#endif
> +	if (!clock_base)	/* TOD_CLOCK_BASE value missing */
>  		return 0;
>  
>  	/* Correct calculation to convert time stamp in trailer entry to
>  	 * nano seconds (taken from arch/s390 function tod_to_ns()).
>  	 * TOD_CLOCK_BASE is stored in trailer entry member progusage2.
>  	 */
> -	aux_time = trailer_timestamp(te) - te->progusage2;
> +	aux_time = trailer_timestamp(te, clock_base) - progusage2;
>  	aux_time = (aux_time >> 9) * 125 + (((aux_time & 0x1ff) * 125) >> 9);
>  	return aux_time;
>  }
> -- 
> 2.19.1

-- 

- Arnaldo
