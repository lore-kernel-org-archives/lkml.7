Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080A5C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDF821655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJGKDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:03:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:49713 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbfJGKDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:03:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 03:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,267,1566889200"; 
   d="scan'208";a="222862683"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2019 03:03:14 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iHPrF-0006TU-BL; Mon, 07 Oct 2019 13:03:13 +0300
Date:   Mon, 7 Oct 2019 13:03:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] intel-speed-select: Add check for CascadeLake-N
 models
Message-ID: <20191007100313.GP32742@smile.fi.intel.com>
References: <20191003121112.25870-1-prarit@redhat.com>
 <20191003121112.25870-4-prarit@redhat.com>
 <b1895913e2adaff4daf7be6b919e50714b418fe8.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1895913e2adaff4daf7be6b919e50714b418fe8.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:15:21AM -0700, Srinivas Pandruvada wrote:
> On Thu, 2019-10-03 at 08:11 -0400, Prarit Bhargava wrote:

> > +	/* only three CascadeLake-N models are supported */
> > +	if (is_clx_n_platform()) {
> > +		FILE *fp;
> > +		size_t n;
> > +		char *line;
> Need n = 0 and *line = NULL here as getline() will require if it has to
> allocate.

Good catch and thus...

> > +		int ret = 1;
> > +
> > +		fp = fopen("/proc/cpuinfo", "r");
> > +		if (!fp)
> > +			err(-1, "cannot open /proc/cpuinfo\n");
> > +
> > +		while (getline(&line, &n, fp) > 0) {

> > +			if (strstr(line, "model name")) {
> > +				if (strstr(line, "6252N") ||
> > +				    strstr(line, "6230N") ||
> > +				    strstr(line, "5218N"))
> > +					ret = 0;
> > +				break;
> > +			}

Missed free(line) here.

> > +		}
> > +		free(line);
> > +		fclose(fp);
> > +		return ret;
> > +	}
> > +	return 0;
> >  }
> >  
> >  /* Open a file, and exit on failure */
> > @@ -1889,7 +1927,9 @@ static void cmdline(int argc, char **argv)
> >  		fprintf(stderr, "Feature name and|or command not
> > specified\n");
> >  		exit(0);
> >  	}
> > -	update_cpu_model();
> > +	ret = update_cpu_model();
> > +	if (ret)
> > +		err(-1, "Invalid CPU model (%d)\n", cpu_model);
> >  	printf("Intel(R) Speed Select Technology\n");
> >  	printf("Executing on CPU model:%d[0x%x]\n", cpu_model,
> > cpu_model);
> >  	set_max_cpu_num();
> 

-- 
With Best Regards,
Andy Shevchenko


