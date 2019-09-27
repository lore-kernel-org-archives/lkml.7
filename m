Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49767C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B70520872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGpvoGmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfI0Czb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:55:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43009 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfI0Czb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:55:31 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so12296161iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 19:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDUa1q53dfu0Ixw6H7h9jXl5AfHjmWORWSwEBG7Wig4=;
        b=BGpvoGmMbXh5mNJl+6NSpIX3PN4KHCFkYCtPSDMoRSW150t5DfU1QdLbA4JO6l3EBn
         zt3w9t8/qSd/EJ5h7Waj1mz+0mI3RpdzUxiIG7EQcWqKHNb8s2gLm+T9sTNKK43kAiVE
         yjhjEGdTt3Ix1M25RejCBCO6oIVLZWn+emES6bbD49ZxM8Y83mGHvWm664vkC7vEiNt/
         9CMtAgUXZ0vFo4tI86bRO2mlo4ESDYBby8A4IwdqHImSCFpSdzVNBBXSxr+5PVal4aLT
         ACtcflxaHkE2juHtMKY8j7ZiBsWJzLytFnMktvt38J58vCHdkCF4qqzmt8tT53D1OIlj
         AT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDUa1q53dfu0Ixw6H7h9jXl5AfHjmWORWSwEBG7Wig4=;
        b=f5iuGf3rlItcgxt1eoWoAcIsB0US5Qu1vrqTPygr7PvVJ6YOQAg6CjV8AZ/KC0G5NE
         hhBU0YXuiWadMCsN3PqBXBnsk9dGD3WL38B4HOoe00rYOiJkzxi6/fXd0xuxmDLLI+he
         E0zgLuupDupsiIRMhcnQKaQwPUXqd8Vi3UI6bOuLGEio4MNZN7+/PEl4HWnsTyeN+uGd
         kvq4j2Ix/o6fnNEbyRQ0/D3oAhYYKsXq7cl2ktnPEMCnrWJyidJm2npG7KpNZwaQP0jv
         IxJKwDzGEbR9swpycmsVGVn2DHqwwsNV17m8RpVSlX9Ni5BPQYKDKrHsaQ+xPnptUtHl
         pVDQ==
X-Gm-Message-State: APjAAAXVRppP/mhiuXZOzTaiq+tVgatqAVAQp1ZLfKPxmr7WiVUt2YZV
        plsx1YaettDtjm7TdT5M+cE=
X-Google-Smtp-Source: APXvYqwIgoACEUJ19xm2YJrWljbq6VeDHjFjnasmTGKn4vvEUFmkNgHypAuZA/FpqdAOy31uOHt7gg==
X-Received: by 2002:a92:a1d6:: with SMTP id b83mr2465039ill.76.1569552930032;
        Thu, 26 Sep 2019 19:55:30 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.gmail.com with ESMTPSA id t9sm1895080iop.86.2019.09.26.19.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 19:55:29 -0700 (PDT)
Date:   Thu, 26 Sep 2019 21:55:26 -0500
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: prevent memory leak in
 snd_skl_parse_uuids
Message-ID: <20190927025526.GD22969@cs-dulles.cs.umn.edu>
References: <20190925161922.22479-1-navid.emamdoost@gmail.com>
 <13f4bd40-dbaa-e24e-edca-4b4acff9d9c5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13f4bd40-dbaa-e24e-edca-4b4acff9d9c5@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 12:05:28PM -0500, Pierre-Louis Bossart wrote:
> On 9/25/19 11:19 AM, Navid Emamdoost wrote:
> > In snd_skl_parse_uuids if allocation for module->instance_id fails, the
> > allocated memory for module shoulde be released. I changes the
> > allocation for module to use devm_kzalloc to be resource_managed
> > allocation and avoid the release in error path.
> 
> if you use devm_, don't you need to fix the error path as well then, I see a
> kfree(uuid) in skl_freeup_uuid_list().
> 
> I am not very familiar with this code but the error seems to be that the
> list_add_tail() is called after the module->instance_id is allocated, so
> there is a risk that the module allocated earlier is not freed (since it's
> not yet added to the list). Freeing the module as done in patch 1 works,
> using devm_ without fixing the error path does not seem correct to me.
> 
Thanks for the feedback, then it's your call if you can accept patch 1 as
fix.

Navid.
> > 
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> > Changes in v2:
> > 	- Changed the allocation for module from kzalloc to devm_kzalloc
> > ---
> >   sound/soc/intel/skylake/skl-sst-utils.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
> > index d43cbf4a71ef..ac37f04b0eea 100644
> > --- a/sound/soc/intel/skylake/skl-sst-utils.c
> > +++ b/sound/soc/intel/skylake/skl-sst-utils.c
> > @@ -284,7 +284,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
> >   	 */
> >   	for (i = 0; i < num_entry; i++, mod_entry++) {
> > -		module = kzalloc(sizeof(*module), GFP_KERNEL);
> > +		module = devm_kzalloc(ctx->dev, sizeof(*module), GFP_KERNEL);
> >   		if (!module) {
> >   			ret = -ENOMEM;
> >   			goto free_uuid_list;
> > 
> 
