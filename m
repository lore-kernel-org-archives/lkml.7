Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACD6C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEB3214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XYTCI693"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfIONyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:54:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:44311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIONyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568555659;
        bh=qE2rimZVhY5KReVTDW5tF4eT57EZArIIrbtHQ5nBDHQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XYTCI693d2ijSGSg4LVVfmwjTAzDhhiWZZrYWWTLb6pGZhSs8KMcmDWduhRYXYDbx
         b4GULI09w4LJnonffFbJsfpbo0UnWSQVdEZuKpMzSp/NtrztuvSoJzeELqo9uGYzBW
         Yuc0+L3W4AhTVfCnGW5uHNXPVJYf1KGQQjngSLVU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.90]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhjeH-1iVxhy0fOz-00mrsW; Sun, 15
 Sep 2019 15:54:19 +0200
Subject: Re: [PATCH] staging: bcm2835-audio: Fix draining behavior regression
To:     Takashi Iwai <tiwai@suse.de>, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190914152405.7416-1-tiwai@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <3b41702b-1cc2-233d-94a6-ece8f5a19957@gmx.net>
Date:   Sun, 15 Sep 2019 15:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190914152405.7416-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:i8s22iMN8iwbsXmNfZYqjV1txVC3bumc+Um4/q/ijGaXgLy67NV
 XH3+rZhuhFEH/3EUUTPJeIT8drl/PmkWVcK0TRf3LTI6heh9ZD3yq2Q9DIrk0A1db434lgg
 EgE/zZjb6lnSL1+rRStIBzeK0JsuxWU2RiX4AwNPASIVtdCbjhDQBPqcJxwHYam+YU1zcuy
 h8TwfQwbT08IWDGOCbqsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vptiANhIoxk=:L3mudi4oT/PXgl9bEj1vAn
 XhhYyPHK3g0s8lrL3UMGgbwUVzlSWIWZJKyFEm04SnlnXSHY7ZRzqAtZwCsc0mUkozEME1kZ9
 VQ9pcEqz92czsDBvu48CcK303GzzSlGkYYlyt8M33jvahNJoBPmVHVrZv5EacQvbukOoBHFc9
 t+lHcpKWXzVD22MptPOPIAEMllTAarSqBpznEOQPS+nRykjeZeGqq9xuioQNk+Mr+47SMzYk+
 qFv5j/j0mGeiSen1GBKgU5lU5l2zPWMP7/LfixwCGuY0fjwtpuHbd3x+3X+u0OONwTzsRg7+Y
 cvef+tPT8LPGu2/Xk2RhY+guWYTzfEgUnAt/10BHvah6qYFmRaXOsbW8iYL+Zc2bo693jsEis
 fAhGfQePqZiBTn8Za6HuisWRcRX9YvbLxkxt1/8a5j1sO/d7OKEc+4x/YjQVOxNPk+Fba5I3o
 1wW3QgpXaZO8a9faA6gbNvZrmMbhOnYFq+IptjZnAtxMtojU7HRX1WlkDuPcDwdDi/1cEXR2K
 qEk4Oqa7wCH5nxf7+4MXZHQvtvnvcIdKnvH+80AU/Sx8FfquFW4TApNVouxKN4Z+azwZG9Yc9
 +LIGzbMWszfyncLA64B2Kq3WkOjDM0DdTiP+bhDDVXQ5N5xu0Sn8VOPh3mpJDtX1jGNnDEHs0
 rkXj49MbTXEDU6g73l3olDG3tK1qE5a2e0kQ8DbfYRoAVWQUb5Fv+5k43Gf/k+sjNv+0MUL38
 tWeoUEpmnXkV5BugS3bKUi/i+K8zgJT1e70XZSGOqWmWDF43zZhxLqbWcwE89nY5Tv005vUGJ
 1hAdNi95PGLA65IO9t3dFJ3ww94hA7Xm79YHvi5EdKWu2NhKGznw2KYNrQbGPHekX4snGINUG
 flh3BbYg0IFF3Vf8fuQRy1Gd8J9OIhA2zV7GL633FkNgItcCN4B5tt8KZG9gzRRd03mCgwjUo
 zM/YSwqz6T3cGlHup4HFtKtazbDe/cw3YoRxfCyTTS8rlslEc9v9GDgp4bo0yuNfrrWBgYFYt
 kM+3bkq4kGEroI5Y87aLef2fPQwcE3Y8sbQmCUeMKqrbX5S1Vk53sn/ZuxCawcytk00tsYF0p
 JFRSIwS4dgJj30ODpLM4LfXYUvuKpJlr5eD1FVqgrZLnDNvZZKNrX0iAeJQyktaJoauwEL2zn
 kL+Y8aR4zIx6XrVUgw2cDRWcOknz1XcAy20NcacPBk13rg5fv3Hn9X4ET6iJFbJ+UKolAc6/x
 ly0u77d5mzK0n3OtNTB3gwaXN38cqSqDROk7Sfci7rkh3SaPnl1o2x0V5Jtc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

Am 14.09.19 um 17:24 schrieb Takashi Iwai:
> The PCM draining behavior got broken since the recent refactoring, and
> this turned out to be the incorrect expectation of the firmware
> behavior regarding "draining".  While I expected the "drain" flag at
> the stop operation would do processing the queued samples, it seems
> rather dropping the samples.
>
> As a quick fix, just drop the SNDRV_PCM_INFO_DRAIN_TRIGGER flag, so
> that the driver uses the normal PCM draining procedure.  Also, put
> some caution comment to the function for future readers not to fall
> into the same pitfall.
>
> Fixes: d7ca3a71545b ("staging: bcm2835-audio: Operate non-atomic PCM ops=
")
> BugLink: https://github.com/raspberrypi/linux/issues/2983

thanks for taking care of this. Wouldn't it be better to add the link to
the new comment to provide more context of the unexpected behavior?

Nevertheless:

Acked-by: Stefan Wahren <wahrenst@gmx.net>

> Cc: stable@vger.kernel.org
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c   | 4 ++--
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b=
/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> index bc1eaa3a0773..826016c3431a 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> @@ -12,7 +12,7 @@
>  static const struct snd_pcm_hardware snd_bcm2835_playback_hw =3D {
>  	.info =3D (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER =
|
>  		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> -		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
> +		 SNDRV_PCM_INFO_SYNC_APPLPTR),
>  	.formats =3D SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
>  	.rates =3D SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
>  	.rate_min =3D 8000,
> @@ -29,7 +29,7 @@ static const struct snd_pcm_hardware snd_bcm2835_playb=
ack_hw =3D {
>  static const struct snd_pcm_hardware snd_bcm2835_playback_spdif_hw =3D =
{
>  	.info =3D (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER =
|
>  		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> -		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
> +		 SNDRV_PCM_INFO_SYNC_APPLPTR),
>  	.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
>  	.rates =3D SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_44100 |
>  	SNDRV_PCM_RATE_48000,
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c=
 b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> index 23fba01107b9..c6f9cf1913d2 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> @@ -289,6 +289,7 @@ int bcm2835_audio_stop(struct bcm2835_alsa_stream *a=
lsa_stream)
>  					 VC_AUDIO_MSG_TYPE_STOP, false);
>  }
>
> +/* FIXME: this doesn't seem working as expected for "draining" */
>  int bcm2835_audio_drain(struct bcm2835_alsa_stream *alsa_stream)
>  {
>  	struct vc_audio_msg m =3D {
