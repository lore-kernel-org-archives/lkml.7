Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893BDC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B00D20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfJGTSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:18:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:21010 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGTSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:18:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 12:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="344820197"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga004.jf.intel.com with ESMTP; 07 Oct 2019 12:18:00 -0700
Message-ID: <00b61947ffe509d02383903a059067517dd2605c.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/7] intel-speed-select: Add check for CascadeLake-N
 models
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Oct 2019 12:18:00 -0700
In-Reply-To: <20191007100313.GP32742@smile.fi.intel.com>
References: <20191003121112.25870-1-prarit@redhat.com>
         <20191003121112.25870-4-prarit@redhat.com>
         <b1895913e2adaff4daf7be6b919e50714b418fe8.camel@linux.intel.com>
         <20191007100313.GP32742@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 13:03 +0300, Andy Shevchenko wrote:
> On Fri, Oct 04, 2019 at 10:15:21AM -0700, Srinivas Pandruvada wrote:
> > On Thu, 2019-10-03 at 08:11 -0400, Prarit Bhargava wrote:
> > > +	/* only three CascadeLake-N models are supported */
> > > +	if (is_clx_n_platform()) {
> > > +		FILE *fp;
> > > +		size_t n;
> > > +		char *line;
> > 
> > Need n = 0 and *line = NULL here as getline() will require if it
> > has to
> > allocate.
> 
> Good catch and thus...
> 
> > > +		int ret = 1;
> > > +
> > > +		fp = fopen("/proc/cpuinfo", "r");
> > > +		if (!fp)
> > > +			err(-1, "cannot open /proc/cpuinfo\n");
> > > +
> > > +		while (getline(&line, &n, fp) > 0) {
> > > +			if (strstr(line, "model name")) {
> > > +				if (strstr(line, "6252N") ||
> > > +				    strstr(line, "6230N") ||
> > > +				    strstr(line, "5218N"))
> > > +					ret = 0;
> > > +				break;
> > > +			}
> 
> Missed free(line) here.
This may not be required. After the first call geline() allocated a
buffer and will reuse it during next call. If it is not enough it will
realloc even if the buffer is passed by user via malloc().

From man page:

"
If *lineptr is set to NULL and *n is set 0 before the call, then
       getline() will allocate a buffer for storing the line.  This
buffer
       should be freed by the user program even if getline() failed.

       Alternatively, before calling getline(), *lineptr can contain a
       pointer to a malloc(3)-allocated buffer *n bytes in size.  If
the
       buffer is not large enough to hold the line, getline() resizes
it
       with realloc(3), updating *lineptr and *n as necessary.

       In either case, on a successful call, *lineptr and *n will be
updated
       to reflect the buffer address and allocated size respectively.
"

> 
> > > +		}
> > > +		free(line);
> > > +		fclose(fp);
> > > +		return ret;
> > > +	}
> > > +	return 0;
> > >  }
> > >  
> > >  /* Open a file, and exit on failure */
> > > @@ -1889,7 +1927,9 @@ static void cmdline(int argc, char **argv)
> > >  		fprintf(stderr, "Feature name and|or command not
> > > specified\n");
> > >  		exit(0);
> > >  	}
> > > -	update_cpu_model();
> > > +	ret = update_cpu_model();
> > > +	if (ret)
> > > +		err(-1, "Invalid CPU model (%d)\n", cpu_model);
> > >  	printf("Intel(R) Speed Select Technology\n");
> > >  	printf("Executing on CPU model:%d[0x%x]\n", cpu_model,
> > > cpu_model);
> > >  	set_max_cpu_num();
> 
> 

