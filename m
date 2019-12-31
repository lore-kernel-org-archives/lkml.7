Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DDAC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49254206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLaKMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:12:33 -0500
Received: from gofer.mess.org ([88.97.38.141]:47535 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfLaKMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:12:33 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 3DF4B11A001; Tue, 31 Dec 2019 10:12:31 +0000 (GMT)
Date:   Tue, 31 Dec 2019 10:12:31 +0000
From:   Sean Young <sean@mess.org>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] media: dvb_dummy_frontend: remove 'extern' keyword
 from declaration
Message-ID: <20191231101230.GF24469@gofer.mess.org>
References: <20191201161542.69535-1-dwlsalmeida@gmail.com>
 <20191201161542.69535-7-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201161542.69535-7-dwlsalmeida@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, Dec 01, 2019 at 01:15:42PM -0300, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix CHECK:AVOID_EXTERNS: extern prototypes should be avoided in .h files
> by removing it.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  drivers/media/dvb-frontends/dvb_dummy_fe.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/dvb_dummy_fe.h b/drivers/media/dvb-frontends/dvb_dummy_fe.h
> index 35efe2ce1a88..1c82338e0c8a 100644
> --- a/drivers/media/dvb-frontends/dvb_dummy_fe.h
> +++ b/drivers/media/dvb-frontends/dvb_dummy_fe.h
> @@ -12,9 +12,9 @@
>  #include <media/dvb_frontend.h>
>  
>  #if IS_REACHABLE(CONFIG_DVB_DUMMY_FE)
> -extern struct dvb_frontend *dvb_dummy_fe_ofdm_attach(void);
> -extern struct dvb_frontend *dvb_dummy_fe_qpsk_attach(void);
> -extern struct dvb_frontend *dvb_dummy_fe_qam_attach(void);
> +struct dvb_frontend *dvb_dummy_fe_ofdm_attach(void);
> +struct dvb_frontend *dvb_dummy_fe_qpsk_attach(void);
> +struct dvb_frontend *dvb_dummy_fe_qam_attach(void);

Please add these changes to your patch:
"media: dvb_dummy_fe: Fix ERROR: POINTER_LOCATION"

Every patch should pass the checkpatch --strict test by itself; you
cannot fix checkpatch errors in a patch in a subsequent patch.

Thanks,
Sean

>  #else
>  static inline struct dvb_frontend *dvb_dummy_fe_ofdm_attach(void)
>  {
> -- 
> 2.24.0
