Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6B1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC2C206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfKMRSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:18:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:62542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfKMRSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:18:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 09:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; 
   d="scan'208";a="229813198"
Received: from dmsnyder-mobl1.amr.corp.intel.com (HELO [10.252.193.15]) ([10.252.193.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2019 09:18:02 -0800
Subject: Re: [alsa-devel] [PATCH v5 1/6] ASoC: amd:Create multiple I2S
 platform device Endpoint
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alexander.Deucher@amd.com,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <1573629249-13272-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573629249-13272-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2febc57c-5cca-b8bd-afdf-a4d77b48c3b0@linux.intel.com>
Date:   Wed, 13 Nov 2019 10:11:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573629249-13272-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   static void snd_acp3x_remove(struct pci_dev *pci)
>   {
> +	int i;
>   	struct acp3x_dev_data *adata = pci_get_drvdata(pci);

nit-pick: a lot of kernel folks like xmas-tree style, with counters and 
return status declared last.

>   
> -	platform_device_unregister(adata->pdev);
> +	if (adata->acp3x_audio_mode == ACP3x_I2S_MODE) {
> +		for (i = 0 ; i <  ACP3x_DEVS ; i++)
> +			platform_device_unregister(adata->pdev[i]);
> +	}
>   	iounmap(adata->acp3x_base);
>   
>   	pci_disable_msi(pci);
