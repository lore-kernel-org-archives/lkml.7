Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CBDC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4AC2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMLKZ+W4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEFKQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:16:03 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38608 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEFKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:16:03 -0400
Received: by mail-ua1-f67.google.com with SMTP id t15so4446769uao.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enXB3pGITPNRJuKMqW7F+JCj3PBlivzFrS51DAFNNTo=;
        b=bMLKZ+W4hrHdVV7slmGwuaAQQPoWM7/AQpDBCdhVaJN7P6/rSvhviDkO3+5llfie2m
         88gQT31DTeh2oJ+f3xvzza27LMuK4Sz5V3U5tkDcJ+tHYrxg5RBuqMcRz8/7PuRANdAw
         c7GnMmoQ3P76VeZIIu1KXlHR/gdd5OjA8ALsSOJnJr049bEFXo1IhOqGY+o3j/A+TiQ3
         HHAAtllpeYrcw18+KnodQtI7TaWx0/O9LKpycYE4Bd4/t+dx5+0A0zm4gShvgP17DKKT
         HQvi8colCvwHUmyyJtYeMm9VCP4/0QgZgZl/NuJR9cvEmO8bBHy4WcSkLvQ8Ou2hg8Ak
         UTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enXB3pGITPNRJuKMqW7F+JCj3PBlivzFrS51DAFNNTo=;
        b=dctPJD8kzSJfpsP/iM0rdK7vd40RnVPxvSWk3sfsKrdqyz3O3B8Gg8psIjrLmASpx0
         OtCfyxGEh/LEhn3/FCMPZ5C4g6b81Zfp2r/i112byh1LVkPf1xTObGchyP96s4xDZA+J
         Yeomx1Mg41yHxS9LG6Xpl8G8gwhgMOBMJyCX1AicRqPqn3z3oVv2o4D9R+fQ3ln1prjI
         7H6S+nwHC4lDlpTYoU82eb4ScB3BkF5fLTjjKWpiKnOj8MekGzDsd5N6JZprZ3+tDXQx
         VJGkEvEHwXC2N8/OTi/X6WYu+PBxx6SX6UNSM1jrl4ZbSRjVb4IIqSbk2kBNb3fudJ4Y
         H/Fw==
X-Gm-Message-State: APjAAAV79V5Npfgyv1mZbzWGvVNV8d00A4dEXgeymSGEFoevPwZq1zwL
        uGy/otqKCRrz9SqDjH2xMg4NtAikb8eB5mrE9o/vZw==
X-Google-Smtp-Source: APXvYqy7tyhEAzgfKezcYqIn2lw9DFEJlFeDkeTTA8JtV00z9bqWW11Cx7Osrb1aSXZDN3axfYuskrHaLu+r29OW3iI=
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr7452938uam.85.1557137762284;
 Mon, 06 May 2019 03:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190504135608.176687-1-jannh@google.com>
In-Reply-To: <20190504135608.176687-1-jannh@google.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 6 May 2019 13:15:36 +0300
Message-ID: <CAFCwf13x2TYDtu7UvzKrntzGL3bxB96kQEFrKDRdV0-h2qeL2g@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix debugfs code
To:     Jann Horn <jannh@google.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 4, 2019 at 4:56 PM Jann Horn <jannh@google.com> wrote:
>
> This fixes multiple things in the habanalabs debugfs code, in particular:
>
>  - mmu_write() was unnecessarily verbose, copying around between multiple
>    buffers
>  - mmu_write() could write a user-specified, unbounded amount of userspace
>    memory into a kernel buffer (out-of-bounds write)
>  - multiple debugfs read handlers ignored the user-supplied count,
>    potentially corrupting out-of-bounds userspace data
>  - hl_device_read() was unnecessarily verbose
>  - hl_device_write() could read uninitialized stack memory
>  - multiple debugfs read handlers copied terminating null characters to
>    userspace
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> compile-tested only, so you might want to test this before applying the
> patch
>
>  drivers/misc/habanalabs/debugfs.c | 60 ++++++++++---------------------
>  1 file changed, 18 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
> index 974a87789bd86..17ba26422b297 100644
> --- a/drivers/misc/habanalabs/debugfs.c
> +++ b/drivers/misc/habanalabs/debugfs.c
> @@ -459,41 +459,31 @@ static ssize_t mmu_write(struct file *file, const char __user *buf,
>         struct hl_debugfs_entry *entry = s->private;
>         struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
>         struct hl_device *hdev = dev_entry->hdev;
> -       char kbuf[MMU_KBUF_SIZE], asid_kbuf[MMU_ASID_BUF_SIZE],
> -               addr_kbuf[MMU_ADDR_BUF_SIZE];
> +       char kbuf[MMU_KBUF_SIZE];
>         char *c;
>         ssize_t rc;
>
>         if (!hdev->mmu_enable)
>                 return count;
>
> -       memset(kbuf, 0, sizeof(kbuf));
> -       memset(asid_kbuf, 0, sizeof(asid_kbuf));
> -       memset(addr_kbuf, 0, sizeof(addr_kbuf));
> -
> +       if (count > sizeof(kbuf) - 1)
> +               goto err;
>         if (copy_from_user(kbuf, buf, count))
>                 goto err;
> -
> -       kbuf[MMU_KBUF_SIZE - 1] = 0;
> +       kbuf[count] = 0;
>
>         c = strchr(kbuf, ' ');
>         if (!c)
>                 goto err;
> +       *c = '\0';
>
> -       memcpy(asid_kbuf, kbuf, c - kbuf);
> -
> -       rc = kstrtouint(asid_kbuf, 10, &dev_entry->mmu_asid);
> +       rc = kstrtouint(kbuf, 10, &dev_entry->mmu_asid);
>         if (rc)
>                 goto err;
>
> -       c = strstr(kbuf, " 0x");
> -       if (!c)
> +       if (strncmp(c+1, "0x", 2))
>                 goto err;
> -
> -       c += 3;
> -       memcpy(addr_kbuf, c, (kbuf + count) - c);
> -
> -       rc = kstrtoull(addr_kbuf, 16, &dev_entry->mmu_addr);
> +       rc = kstrtoull(c+3, 16, &dev_entry->mmu_addr);
>         if (rc)
>                 goto err;
>
> @@ -525,10 +515,8 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
>         }
>
>         sprintf(tmp_buf, "0x%08x\n", val);
> -       rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
> -                       strlen(tmp_buf) + 1);
> -
> -       return rc;
> +       return simple_read_from_buffer(buf, count, ppos, tmp_buf,
> +                       strlen(tmp_buf));
>  }
>
>  static ssize_t hl_data_write32(struct file *f, const char __user *buf,
> @@ -559,7 +547,6 @@ static ssize_t hl_get_power_state(struct file *f, char __user *buf,
>         struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
>         struct hl_device *hdev = entry->hdev;
>         char tmp_buf[200];
> -       ssize_t rc;
>         int i;
>
>         if (*ppos)
> @@ -574,10 +561,8 @@ static ssize_t hl_get_power_state(struct file *f, char __user *buf,
>
>         sprintf(tmp_buf,
>                 "current power state: %d\n1 - D0\n2 - D3hot\n3 - Unknown\n", i);
> -       rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
> -                       strlen(tmp_buf) + 1);
> -
> -       return rc;
> +       return simple_read_from_buffer(buf, count, ppos, tmp_buf,
> +                       strlen(tmp_buf));
>  }
>
>  static ssize_t hl_set_power_state(struct file *f, const char __user *buf,
> @@ -630,8 +615,8 @@ static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
>         }
>
>         sprintf(tmp_buf, "0x%02x\n", val);
> -       rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
> -                       strlen(tmp_buf) + 1);
> +       rc = simple_read_from_buffer(buf, count, ppos, tmp_buf,
> +                       strlen(tmp_buf));
>
>         return rc;
>  }
> @@ -720,18 +705,9 @@ static ssize_t hl_led2_write(struct file *f, const char __user *buf,
>  static ssize_t hl_device_read(struct file *f, char __user *buf,
>                                         size_t count, loff_t *ppos)
>  {
> -       char tmp_buf[200];
> -       ssize_t rc;
> -
> -       if (*ppos)
> -               return 0;
> -
> -       sprintf(tmp_buf,
> -               "Valid values: disable, enable, suspend, resume, cpu_timeout\n");
> -       rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
> -                       strlen(tmp_buf) + 1);
> -
> -       return rc;
> +       static const char *help =
> +               "Valid values: disable, enable, suspend, resume, cpu_timeout\n";
> +       return simple_read_from_buffer(buf, count, ppos, help, strlen(help));
>  }
>
>  static ssize_t hl_device_write(struct file *f, const char __user *buf,
> @@ -739,7 +715,7 @@ static ssize_t hl_device_write(struct file *f, const char __user *buf,
>  {
>         struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
>         struct hl_device *hdev = entry->hdev;
> -       char data[30];
> +       char data[30] = {0};
>
>         /* don't allow partial writes */
>         if (*ppos != 0)
> --
> 2.21.0.1020.gf2820cf01a-goog
>

Thanks!
Will be applied to my -next branch

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
