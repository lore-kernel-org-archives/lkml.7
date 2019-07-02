Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5DC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04A02173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ZIxqhT7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfGBDpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:45:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40035 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfGBDpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:45:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id c70so12857995qkg.7;
        Mon, 01 Jul 2019 20:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y786NAXu4PJ1/yOc0m6s682Iasf3FFvLwD+AU2zpzZA=;
        b=ZIxqhT7j4xKrbb3zciPjTwX8LXukbJXaGLHmMTW5D3IH3l1uurvxd+IRHm2E05cqQb
         jCdF2Mro7GRvUnsR+N+/dyWTNxjPhnalwbf2pVKUfsetqi3dAwPbfzJFnQISKhEbznRU
         JSz69cdkkvQOb9mTRsVMEeSTWuKhh33/UxMyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y786NAXu4PJ1/yOc0m6s682Iasf3FFvLwD+AU2zpzZA=;
        b=YWGx//Kc5NAg7lLO9vkQ5yQ3PwCunVtbIAijW9XOsDbZLgWm3bRNJqh2vAeeXrg+Mt
         aerUjCquav7rHRRREbyNSSzZcA7h0thmRR5M8/Kgr1C0zf6wChHVfY+GxC+mZatqGaku
         URSlCNHtQKqo369wkpx341bwWFpowm4a9atris/KCoYtzxjA3TT+gQRXNeyggeIb7Fp7
         5nc7m9Q1iEofdBl6R8gak8ZxZMJDycWV0TmnLgPGf//yLKzDAG/M/1MTC8lfHIX9Hew1
         RtLRpBpdgRNU8bHbQublGn0RnfWoUcv3VyOlCzlzlOCgy+asojiZgS3+PaeqCtr6kbAr
         RxbQ==
X-Gm-Message-State: APjAAAXzf1F3uP9sLwmPNiDG2zsLU1YP6+/qTaJQUNwVPx/sthi8TTGq
        AiVL7nMghdh9rWLJ9T5pq6gvSbJOKeulQBGp3Lg=
X-Google-Smtp-Source: APXvYqx5IUtQ53M7iPJ4jpmAI5O8gIP8mKdvEhWkhsLgtoHu8TAM3VUWAHT2PDNR4TMI36k4H+c2ZjSMfI7PgxNRq5E=
X-Received: by 2002:a05:620a:16d6:: with SMTP id a22mr23910647qkn.414.1562039107762;
 Mon, 01 Jul 2019 20:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <1561576395-6429-1-git-send-email-eajames@linux.ibm.com> <20190626194048.GA7374@roeck-us.net>
In-Reply-To: <20190626194048.GA7374@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 2 Jul 2019 03:44:54 +0000
Message-ID: <CACPK8Xf9MC=3oDS4=+Zr3YFW2kKL9X7P8=bDoG_jLTr9=eawkA@mail.gmail.com>
Subject: Re: [PATCH] OCC: FSI and hwmon: Add sequence numbering
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Lei YU <mine260309@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 at 19:41, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Jun 26, 2019 at 02:13:15PM -0500, Eddie James wrote:
> > Sequence numbering of the commands submitted to the OCC is required by
> > the OCC interface specification. Add sequence numbering and check for
> > the correct sequence number on the response.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
>
> For hwmon:
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> I assume this will be pushed through drivers/fsi.

Yes. Eddie, can you please collect the acks and send to Greg?

Cheers,

Joel

>
> Guenter
>
> > ---
> >  drivers/fsi/fsi-occ.c      | 15 ++++++++++++---
> >  drivers/hwmon/occ/common.c |  4 ++--
> >  drivers/hwmon/occ/common.h |  1 +
> >  3 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> > index a2301ce..7da9c81 100644
> > --- a/drivers/fsi/fsi-occ.c
> > +++ b/drivers/fsi/fsi-occ.c
> > @@ -412,6 +412,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
> >               msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
> >       struct occ *occ = dev_get_drvdata(dev);
> >       struct occ_response *resp = response;
> > +     u8 seq_no;
> >       u16 resp_data_length;
> >       unsigned long start;
> >       int rc;
> > @@ -426,6 +427,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
> >
> >       mutex_lock(&occ->occ_lock);
> >
> > +     /* Extract the seq_no from the command (first byte) */
> > +     seq_no = *(const u8 *)request;
> >       rc = occ_putsram(occ, OCC_SRAM_CMD_ADDR, request, req_len);
> >       if (rc)
> >               goto done;
> > @@ -441,11 +444,17 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
> >               if (rc)
> >                       goto done;
> >
> > -             if (resp->return_status == OCC_RESP_CMD_IN_PRG) {
> > +             if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
> > +                 resp->seq_no != seq_no) {
> >                       rc = -ETIMEDOUT;
> >
> > -                     if (time_after(jiffies, start + timeout))
> > -                             break;
> > +                     if (time_after(jiffies, start + timeout)) {
> > +                             dev_err(occ->dev, "resp timeout status=%02x "
> > +                                     "resp seq_no=%d our seq_no=%d\n",
> > +                                     resp->return_status, resp->seq_no,
> > +                                     seq_no);
> > +                             goto done;
> > +                     }
> >
> >                       set_current_state(TASK_UNINTERRUPTIBLE);
> >                       schedule_timeout(wait_time);
> > diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> > index d593517..a7d2b16 100644
> > --- a/drivers/hwmon/occ/common.c
> > +++ b/drivers/hwmon/occ/common.c
> > @@ -124,12 +124,12 @@ struct extended_sensor {
> >  static int occ_poll(struct occ *occ)
> >  {
> >       int rc;
> > -     u16 checksum = occ->poll_cmd_data + 1;
> > +     u16 checksum = occ->poll_cmd_data + occ->seq_no + 1;
> >       u8 cmd[8];
> >       struct occ_poll_response_header *header;
> >
> >       /* big endian */
> > -     cmd[0] = 0;                     /* sequence number */
> > +     cmd[0] = occ->seq_no++;         /* sequence number */
> >       cmd[1] = 0;                     /* cmd type */
> >       cmd[2] = 0;                     /* data length msb */
> >       cmd[3] = 1;                     /* data length lsb */
> > diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> > index fc13f3c..67e6968 100644
> > --- a/drivers/hwmon/occ/common.h
> > +++ b/drivers/hwmon/occ/common.h
> > @@ -95,6 +95,7 @@ struct occ {
> >       struct occ_sensors sensors;
> >
> >       int powr_sample_time_us;        /* average power sample time */
> > +     u8 seq_no;
> >       u8 poll_cmd_data;               /* to perform OCC poll command */
> >       int (*send_cmd)(struct occ *occ, u8 *cmd);
> >
> > --
> > 1.8.3.1
> >
