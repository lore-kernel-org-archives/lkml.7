Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E920C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9A4206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfGaRLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:11:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:45059 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfGaRLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:11:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 10:11:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="323810584"
Received: from deharris-mobl.amr.corp.intel.com ([10.251.148.13])
  by orsmga004.jf.intel.com with ESMTP; 31 Jul 2019 10:11:03 -0700
Message-ID: <918f9c287b7ef9efb707d88560a9ccde577c5dbf.camel@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: SOF: no need to check return
 value of debugfs_create functions
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 10:11:03 -0700
In-Reply-To: <20190731131716.9764-3-gregkh@linuxfoundation.org>
References: <20190731131716.9764-1-gregkh@linuxfoundation.org>
         <20190731131716.9764-3-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 15:17 +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic
> should
> never do something different based on this.
> 
> Also, if a debugfs call fails, userspace is notified with an error in
> the log, so no need to log the error again.
> 
> Because we no longer need to check the return value, there's no need
> to
> save the dentry returned by debugfs.  Just use the dentry in the file
> pointer if we really need to figure out the "name" of the file being
> opened.
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: rebase on 5.3-rc1
>     change Subject line to match the subsystem better
>     rework based on debugfs core now reporting errors.
> 
>  sound/soc/sof/debug.c    | 49 +++++++++++++++-----------------------
> --
>  sound/soc/sof/sof-priv.h |  1 -
>  sound/soc/sof/trace.c    |  9 ++------
>  3 files changed, 20 insertions(+), 39 deletions(-)
> 
> diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
> index 2388477a965e..40940b2fe9d5 100644
> --- a/sound/soc/sof/debug.c
> +++ b/sound/soc/sof/debug.c
> @@ -128,6 +128,7 @@ static ssize_t sof_dfsentry_write(struct file
> *file, const char __user *buffer,
>  	unsigned long ipc_duration_ms = 0;
>  	bool flood_duration_test = false;
>  	unsigned long ipc_count = 0;
> +	struct dentry *dentry;
>  	int err;
>  #endif
>  	size_t size;
> @@ -149,11 +150,12 @@ static ssize_t sof_dfsentry_write(struct file
> *file, const char __user *buffer,
>  	 * ipc_duration_ms test floods the DSP for the time specified
>  	 * in the debugfs entry.
>  	 */
> -	if (strcmp(dfse->dfsentry->d_name.name, "ipc_flood_count") &&
> -	    strcmp(dfse->dfsentry->d_name.name,
> "ipc_flood_duration_ms"))
> +	dentry = file->f_path.dentry;
> +	if (strcmp(dentry->d_name.name, "ipc_flood_count") &&
> +	    strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))
>  		return -EINVAL;
>  
> -	if (!strcmp(dfse->dfsentry->d_name.name,
> "ipc_flood_duration_ms"))
> +	if (!strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))
>  		flood_duration_test = true;
>  
>  	/* test completion criterion */
> @@ -219,6 +221,7 @@ static ssize_t sof_dfsentry_read(struct file
> *file, char __user *buffer,
>  {
>  	struct snd_sof_dfsentry *dfse = file->private_data;
>  	struct snd_sof_dev *sdev = dfse->sdev;
> +	struct dentry *dentry;
>  	loff_t pos = *ppos;
>  	size_t size_ret;
>  	int skip = 0;
> @@ -226,8 +229,9 @@ static ssize_t sof_dfsentry_read(struct file
> *file, char __user *buffer,
>  	u8 *buf;
>  
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST)
> -	if ((!strcmp(dfse->dfsentry->d_name.name, "ipc_flood_count") ||
> -	     !strcmp(dfse->dfsentry->d_name.name,
> "ipc_flood_duration_ms")) &&
> +	dentry = file->f_path.dentry;
> +	if ((!strcmp(dentry->d_name.name, "ipc_flood_count") ||
> +	     !strcmp(dentry->d_name.name, "ipc_flood_duration_ms")) &&
>  	    dfse->cache_buf) {
>  		if (*ppos)
>  			return 0;
> @@ -290,8 +294,7 @@ static ssize_t sof_dfsentry_read(struct file
> *file, char __user *buffer,
>  		if (!pm_runtime_active(sdev->dev) &&
>  		    dfse->access_type == SOF_DEBUGFS_ACCESS_D0_ONLY) {
>  			dev_err(sdev->dev,
> -				"error: debugfs entry %s cannot be read
> in DSP D3\n",
> -				dfse->dfsentry->d_name.name);
> +				"error: debugfs entry cannot be read in
> DSP D3\n");
>  			kfree(buf);
>  			return -EINVAL;
>  		}
> @@ -356,17 +359,11 @@ int snd_sof_debugfs_io_item(struct snd_sof_dev
> *sdev,
>  	}
>  #endif
>  
> -	dfse->dfsentry = debugfs_create_file(name, 0444, sdev-
> >debugfs_root,
> -					     dfse, &sof_dfs_fops);
> -	if (!dfse->dfsentry) {
> -		/* can't rely on debugfs, only log error and keep going
> */
> -		dev_err(sdev->dev, "error: cannot create debugfs entry
> %s\n",
> -			name);
> -	} else {
> -		/* add to dfsentry list */
> -		list_add(&dfse->list, &sdev->dfsentry_list);
> +	debugfs_create_file(name, 0444, sdev->debugfs_root, dfse,
> +			    &sof_dfs_fops);
Minor nit-pick but looks good otherwise. This will fit all in one line
(same with the lines below).
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
 
>  
> -	}
> +	/* add to dfsentry list */
> +	list_add(&dfse->list, &sdev->dfsentry_list);
>  
>  	return 0;
>  }
> @@ -402,16 +399,10 @@ int snd_sof_debugfs_buf_item(struct snd_sof_dev
> *sdev,
>  		return -ENOMEM;
>  #endif
>  
> -	dfse->dfsentry = debugfs_create_file(name, mode, sdev-
> >debugfs_root,
> -					     dfse, &sof_dfs_fops);
> -	if (!dfse->dfsentry) {
> -		/* can't rely on debugfs, only log error and keep going
> */
> -		dev_err(sdev->dev, "error: cannot create debugfs entry
> %s\n",
> -			name);
> -	} else {
> -		/* add to dfsentry list */
> -		list_add(&dfse->list, &sdev->dfsentry_list);
> -	}
> +	debugfs_create_file(name, mode, sdev->debugfs_root, dfse,
> +			    &sof_dfs_fops);
> +	/* add to dfsentry list */
> +	list_add(&dfse->list, &sdev->dfsentry_list);
>  
>  	return 0;
>  }
> @@ -426,10 +417,6 @@ int snd_sof_dbg_init(struct snd_sof_dev *sdev)
>  
>  	/* use "sof" as top level debugFS dir */
>  	sdev->debugfs_root = debugfs_create_dir("sof", NULL);
> -	if (IS_ERR_OR_NULL(sdev->debugfs_root)) {
> -		dev_err(sdev->dev, "error: failed to create debugfs
> directory\n");
> -		return 0;
> -	}
>  
>  	/* init dfsentry list */
>  	INIT_LIST_HEAD(&sdev->dfsentry_list);
> diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
> index b8c0b2a22684..79b6709d1874 100644
> --- a/sound/soc/sof/sof-priv.h
> +++ b/sound/soc/sof/sof-priv.h
> @@ -228,7 +228,6 @@ enum sof_debugfs_access_type {
>  
>  /* FS entry for debug files that can expose DSP memories, registers
> */
>  struct snd_sof_dfsentry {
> -	struct dentry *dfsentry;
>  	size_t size;
>  	enum sof_dfsentry_type type;
>  	/*
> diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
> index befed975161c..4c3cff031fd6 100644
> --- a/sound/soc/sof/trace.c
> +++ b/sound/soc/sof/trace.c
> @@ -148,13 +148,8 @@ static int trace_debugfs_create(struct
> snd_sof_dev *sdev)
>  	dfse->size = sdev->dmatb.bytes;
>  	dfse->sdev = sdev;
>  
> -	dfse->dfsentry = debugfs_create_file("trace", 0444, sdev-
> >debugfs_root,
> -					     dfse,
> &sof_dfs_trace_fops);
> -	if (!dfse->dfsentry) {
> -		/* can't rely on debugfs, only log error and keep going
> */
> -		dev_err(sdev->dev,
> -			"error: cannot create debugfs entry for
> trace\n");
> -	}
> +	debugfs_create_file("trace", 0444, sdev->debugfs_root, dfse,
> +			    &sof_dfs_trace_fops);
>  
>  	return 0;
>  }

