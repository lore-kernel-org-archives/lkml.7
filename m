Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AD8FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE302067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UwKhjA3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394049AbfJPP0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:26:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46998 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393605AbfJPP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:26:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so36675280qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diJbB+ScUhaBfuw1tgZ+SUh+o80AyXb5F7UVVygZwdc=;
        b=UwKhjA3n4llkNh60rELowyKM3+V8XT6FynqBUjBIcBnXjKbPOHak4U0Fn3mW+bXajj
         p9gogvPUZ3IKT1IZIR9Taw1ld620IUhyQfFAbcHVh7h0flOnoDbGJHUl3QosLBmjibfq
         BjUhCJNWfrzVjQpL0cKwI8rxUEhoC4rEuzIWbS2ZeXMM2F94R3AzP7P/8zsmZzAXczVi
         tMYIlhFdAROKm67yqPHAH6lXYjY4QfLnk4tNSZcG6Nt8HRg9zMlrwnxhtCI2EF09ubkD
         1xhuTuR7xWPG9e2QG6yWDqzp2n2YfTP9ixey+MPJgmtJH/e1Zms7sFymTvmDTGqBtmat
         WrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diJbB+ScUhaBfuw1tgZ+SUh+o80AyXb5F7UVVygZwdc=;
        b=GvNbpumD1bvwsij9jhNbOSVdtYfim8KyYsrHyYSH9plz733OcDZNFNT+rhyyVdItJt
         /LOV2NFG9s9rSM+vTha/wlg2LggEwOlttq6temM/k9K2kDm4t/IuadzXEiAvGbBOw24Z
         zrYDFUkw8cHCKQgqW2qNv+umCWCz2cSP6rFql6LsG+Ux/mQAKuFgENCOlLYyZ9KnkjsP
         Bq5Fz/aN0q9W6L5lB9WY+MITG5bG/cjSwF3eCUahgL52jDXDeCsuX1M1Aso3xypWfrb5
         FRwE8Jc8ijQaOb4Ce70AkKuS7IMMdy+0UMPEAwC8fvID5OZPE6V9Izfiyc8rhJeraXI0
         GIeA==
X-Gm-Message-State: APjAAAVab+VGFXX+0qk3MIDusTOPVJKcG35co+T5IITbEgG+5YsiV28S
        0aBu580ZRf13LXKfswWe74xKpw==
X-Google-Smtp-Source: APXvYqwByJbM6vXASbOFVe/GOBrQK1/bwfa0xVfVke4eawZXmV42K4LV1n8SGlywL23+zIXPVKputg==
X-Received: by 2002:ad4:43e9:: with SMTP id f9mr12762509qvu.66.1571239581601;
        Wed, 16 Oct 2019 08:26:21 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u27sm17218916qta.90.2019.10.16.08.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:26:20 -0700 (PDT)
Message-ID: <1571239578.5937.62.camel@lca.pw>
Subject: Re: memory leaks in dasd_eckd_check_characteristics() error paths
From:   Qian Cai <cai@lca.pw>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 11:26:18 -0400
In-Reply-To: <ddc3fb26-2286-de78-70dd-ef0f62bfd6c0@linux.ibm.com>
References: <1570044801.5576.262.camel@lca.pw>
         <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
         <1571234974.5937.53.camel@lca.pw>
         <ddc3fb26-2286-de78-70dd-ef0f62bfd6c0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 16:56 +0200, Stefan Haberland wrote:
> On 16.10.19 16:09, Qian Cai wrote:
> > On Wed, 2019-10-16 at 15:29 +0200, Stefan Haberland wrote:
> > > Hi,
> > > 
> > > thanks for reporting this.
> > > 
> > > On 02.10.19 21:33, Qian Cai wrote:
> > > > For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
> > > > dasd_generic_set_online() emits this message,
> > > > 
> > > > dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12
> > > > 
> > > > After that, there are several memory leaks below. There are "config_data" and
> > > > then stored as,
> > > > 
> > > > /* store per path conf_data */
> > > > device->path[pos].conf_data = conf_data;
> > > > 
> > > > When it processes the error path in  dasd_generic_set_online(), it calls
> > > > dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
> > > > the device->path[].conf_data first. 
> > > 
> > > Usually dasd_delete_device() calls dasd_generic_free_discipline() which
> > > takes care of
> > > the device->path[].conf_data in dasd_eckd_uncheck_device().
> > > From a first look this looks sane.
> > > 
> > > So I need to spend a closer look if this does not happen correctly here.
> > 
> > When dasd_eckd_check_characteristics() failed here,
> > 
> > 	if (!private) {
> > 		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
> > 		if (!private) {
> > 			dev_warn(&device->cdev->dev,
> > 				 "Allocating memory for private DASD data "
> > 				 "failed\n");
> > 			return -ENOMEM;
> > 		}
> > 		device->private = private;
> > 
> > The device->private is NULL.
> > 
> > Then, in dasd_eckd_uncheck_device(), it will return immediately.
> > 
> > 	if (!private)
> > 		return;
> 
> Yes but in this case there is no per_path configuration data stored.
> This is done after the private structure is allocated successfully.

Yes, you are right. It has been a while so I must lost a bit memory. Actually,
it looks like in dasd_eckd_check_characteristic() that device->private is set to
NULL from this path,

	/* Read Configuration Data */
	rc = dasd_eckd_read_conf(device);
	if (rc)
		goto out_err1;

out_err1:
	kfree(private->conf_data);
	kfree(device->private);
	device->private = NULL;
	return rc;

because dasd_eckd_read_conf() returns -ENOMEM and calls,

out_error:
	kfree(rcd_buf);
	*rcd_buffer = NULL;
	*rcd_buffer_size = 0;
	return ret;

It will only free its own config_data in one operational path, but there could
has already allocated in earlier paths in dasd_eckd_read_conf() without any
rollback and calls return,

	for (lpm = 0x80; lpm; lpm>>= 1) {
		if (!(lpm & opm))
			continue;
		rc = dasd_eckd_read_conf_lpm(device, &conf_data,
					     &conf_len, lpm);
		if (rc && rc != -EOPNOTSUPP) {	/* -EOPNOTSUPP is ok */
			DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
					"Read configuration data returned "
					"error %d", rc);
			return rc;
		}

Later, dasd_eckd_uncheck_device() see private->device is NULL without cleaning
up. Does it make sense?

> 
> 
> > > > Is it safe to free those in
> > > > dasd_free_device() without worrying about the double-free? Or, is it better to
> > > > free those in dasd_eckd_check_characteristics()'s goto error handling, i.e.,
> > > > out_err*?
> > > > 
> > > > --- a/drivers/s390/block/dasd.c
> > > > +++ b/drivers/s390/block/dasd.c
> > > > @@ -153,6 +153,9 @@ struct dasd_device *dasd_alloc_device(void)
> > > >   */
> > > >  void dasd_free_device(struct dasd_device *device)
> > > >  {
> > > > +       for (int i = 0; i < 8; i++)
> > > > +               kfree(device->path[i].conf_data);
> > > > +
> > > >         kfree(device->private);
> > > >         free_pages((unsigned long) device->ese_mem, 1);
> > > >         free_page((unsigned long) device->erp_mem);
> > > > 
> > > > 
> > > > unreferenced object 0x0fcee900 (size 256):
> > > >   comm "dasdconf.sh", pid 446, jiffies 4294940081 (age 170.340s)
> > > >   hex dump (first 32 bytes):
> > > >     dc 01 01 00 f0 f0 f2 f1 f0 f7 f9 f0 f0 c9 c2 d4  ................
> > > >     f7 f5 f0 f0 f0 f0 f0 f0 f0 c6 d9 c2 f7 f1 62 33  ..............b3
> > > >   backtrace:
> > > >     [<00000000a83b1992>] kmem_cache_alloc_trace+0x200/0x388
> > > >     [<00000000048ef3e2>] dasd_eckd_read_conf+0x408/0x1400 [dasd_eckd_mod]
> > > >     [<00000000ce31f195>] dasd_eckd_check_characteristics+0x3cc/0x938
> > > > [dasd_eckd_mod]
> > > >     [<00000000f6f1759b>] dasd_generic_set_online+0x150/0x4c0
> > > >     [<00000000efca1efa>] ccw_device_set_online+0x324/0x808
> > > >     [<00000000f9779774>] online_store_recog_and_online+0xe8/0x220
> > > >     [<00000000349a5446>] online_store+0x2ce/0x420
> > > >     [<000000005bd145f8>] kernfs_fop_write+0x1bc/0x270
> > > >     [<0000000005664197>] vfs_write+0xce/0x220
> > > >     [<0000000044a8bccb>] ksys_write+0xea/0x190
> > > >     [<0000000037335938>] system_call+0x296/0x2b4
> 
> 
