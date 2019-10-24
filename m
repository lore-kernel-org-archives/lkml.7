Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB4DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379F52166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afCooXJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391256AbfJXNtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:49:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38276 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732240AbfJXNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:49:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id o25so24545521qtr.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vBgdRFvyWR+zBWshZROh6GlWfRoQ4jqVQ5N1n5QJhXg=;
        b=afCooXJODDM2HvU+zFctJfl2NbKFym2rAe+NpIjApP/ZjLNa2qmOt96I57kVgP1H36
         craU2rpfdHBARcmnj39LniNNlmH5ocvyiznXCvMt21dzV3L28V/0FwCg8oJGjNa5CWoz
         0066xWx/qD0B7taVbxvv1aBiH/bhOl9M9banOmEz6ZHy2/vzgWlOKML/VWFxLK2tah9b
         X+xJ0Vqt3iQXBlKQaehRVU1UTox49kHYXGJLXPp7aZhn6pEsZBKk3EQ4I3FYQxramaWH
         dlQZhd7356glgnrPnO5Bae+7QiZqLxX6CIpc7RV+JwHNd04m28NOF2nsPba7p/lSf6ES
         gV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vBgdRFvyWR+zBWshZROh6GlWfRoQ4jqVQ5N1n5QJhXg=;
        b=FtNx4JGCQ7gDHc380kBaroxJXOE5VVxQ8Z/r/c/+F5g3NoMrr/6+jKrazScekY6jgJ
         w2rjg78kcfLRBZEF9e9z9PdPhTM594j+rKkrlFAalMA6wTiuv95rur1b8NE74Gw6BgF2
         lKA07s11TZ4WwTAzvaCAzdtMeJeEaGSfh17ru8/bt8rNRfFo6FtfsnPet6eROxLbNlQ+
         7hn/zWV+KXijXTxCAs99V1LLRMsuL1AVfL8pDBKkBVPx6PTDQNxIshUSv3K8KzSrpr11
         I+oFY+TyuX4B1WOEa2YELK62noCmdLhWXj6FCuKtljbZERIhM9ochCX+NT/5fTbookLE
         LwIA==
X-Gm-Message-State: APjAAAVzGzNfBtneX9FkrkretItUopIn91hYQ7gH8wvkkbDrHmxCiL6Q
        D6ncutlFo+JTW3YVBd7GMuQ=
X-Google-Smtp-Source: APXvYqyzJUC5/goC8sShMyMthpjrhZosMNEwZ32KjRySFCjJJQEJn+u7kbnd6g8YBSoGrmHjIyspJQ==
X-Received: by 2002:ad4:568d:: with SMTP id bc13mr14906293qvb.102.1571924942256;
        Thu, 24 Oct 2019 06:49:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 14sm12494775qtb.54.2019.10.24.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:49:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAF744DDC9; Thu, 24 Oct 2019 10:48:58 -0300 (-03)
Date:   Thu, 24 Oct 2019 10:48:58 -0300
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        lukemujica@google.com, kan.liang@linux.intel.com,
        yuzenghui@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2] perf jevents: Fix resource leak in process_mapfile()
 and main()
Message-ID: <20191024134858.GB1666@kernel.org>
References: <d7907042-ec9c-2bef-25b4-810e14602f89@huawei.com>
 <20191016142536.GH22835@kernel.org>
 <b4aea0a8-f0a5-d439-e8c9-1b88841300be@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4aea0a8-f0a5-d439-e8c9-1b88841300be@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 23, 2019 at 04:22:25PM +0800, Yunfeng Ye escreveu:
> 
> 
> On 2019/10/16 22:25, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Oct 16, 2019 at 09:50:17PM +0800, Yunfeng Ye escreveu:
> >> There are memory leaks and file descriptor resource leaks in
> >> process_mapfile() and main().
> >>
> >> Fix this by adding free(), fclose() and free_arch_std_events()
> >> on the error paths.
> >>
> >> Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> >> Fixes: 3f056b66647b ("perf jevents: Make build fail on JSON parse error")
> >> Fixes: e9d32c1bf0cd ("perf vendor events: Add support for arch standard events")
> > 
> > Nice, thanks for adding the fixes line, I looked at those three patches
> > and indeed they were leaky, thanks for the fixes, we shouldn't have
> > those leaks even if that, for now, makes the tool to end anyway.
> > 
> The other 3 patchs have been applied, is this patch applied ? thanks.

Applied now, thanks for the reminder,

- Arnaldo
 
> > - Arnaldo
> > 
> >> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> >> ---
> >> v1 -> v2:
> >>  - add free(eventsfp) to fix eventsfp resource leaks
> >>  - add free_arch_std_events() on the error path
> >>
> >>  tools/perf/pmu-events/jevents.c | 13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> >> index e2837260ca4d..99e3fd04a5cb 100644
> >> --- a/tools/perf/pmu-events/jevents.c
> >> +++ b/tools/perf/pmu-events/jevents.c
> >> @@ -758,6 +758,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
> >>  	char *line, *p;
> >>  	int line_num;
> >>  	char *tblname;
> >> +	int ret = 0;
> >>
> >>  	pr_info("%s: Processing mapfile %s\n", prog, fpath);
> >>
> >> @@ -769,6 +770,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
> >>  	if (!mapfp) {
> >>  		pr_info("%s: Error %s opening %s\n", prog, strerror(errno),
> >>  				fpath);
> >> +		free(line);
> >>  		return -1;
> >>  	}
> >>
> >> @@ -795,7 +797,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
> >>  			/* TODO Deal with lines longer than 16K */
> >>  			pr_info("%s: Mapfile %s: line %d too long, aborting\n",
> >>  					prog, fpath, line_num);
> >> -			return -1;
> >> +			ret = -1;
> >> +			goto out;
> >>  		}
> >>  		line[strlen(line)-1] = '\0';
> >>
> >> @@ -825,7 +828,9 @@ static int process_mapfile(FILE *outfp, char *fpath)
> >>
> >>  out:
> >>  	print_mapping_table_suffix(outfp);
> >> -	return 0;
> >> +	fclose(mapfp);
> >> +	free(line);
> >> +	return ret;
> >>  }
> >>
> >>  /*
> >> @@ -1122,6 +1127,7 @@ int main(int argc, char *argv[])
> >>  		goto empty_map;
> >>  	} else if (rc < 0) {
> >>  		/* Make build fail */
> >> +		fclose(eventsfp);
> >>  		free_arch_std_events();
> >>  		return 1;
> >>  	} else if (rc) {
> >> @@ -1134,6 +1140,7 @@ int main(int argc, char *argv[])
> >>  		goto empty_map;
> >>  	} else if (rc < 0) {
> >>  		/* Make build fail */
> >> +		fclose(eventsfp);
> >>  		free_arch_std_events();
> >>  		return 1;
> >>  	} else if (rc) {
> >> @@ -1151,6 +1158,8 @@ int main(int argc, char *argv[])
> >>  	if (process_mapfile(eventsfp, mapfile)) {
> >>  		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
> >>  		/* Make build fail */
> >> +		fclose(eventsfp);
> >> +		free_arch_std_events();
> >>  		return 1;
> >>  	}
> >>
> >> -- 
> >> 2.7.4.3
> > 

-- 

- Arnaldo
