Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C802FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B1021925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hYNlRyNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393829AbfJPOJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:09:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36989 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731923AbfJPOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:09:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so22872918qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbLFFtj39kkBf5dkql9MHXopp0F39M0Fqhm7mWy045Q=;
        b=hYNlRyNg8vFkPzQVjv108oF4X8imWdsQPeb/8uXTjEjUOy2It0rTxwvHdKZRnbWsPU
         J59C6GVORFOefgDVmVnjQ2ZaIWKqY57UT+V8TKW/gyo3/fd5onIlYYDS1Eo9oQfLZxcL
         D7J2kgXHUaF68hu6JZXtoQa0NwkrIJaQcNH11dPZWTJjpYudzSFkPAwbn3d20DWx/7Bf
         0rQgUlwzXXdWD4GAc+DepazemS/sWxYAoCKeNO/UZ593WshwWTPyYgSRmndPfLtOo8OI
         LHWu72OE5xIRuhFV3RVQ8Go+/THXlgYZWQ8I5knmow52XH6LpW009GTtXPrguFNOCuur
         dO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbLFFtj39kkBf5dkql9MHXopp0F39M0Fqhm7mWy045Q=;
        b=pD6Lvr85NrYpgaDM6Zf1GDbj43C91/VO9+3bGFjqFyX+1tRUdG/dV4MgQxmWjCHWFa
         TtRD1ygwur2yQwmpbYGCt72ENTTuMAOvN3Iqk15e6l1Q9q3Slr9DSK6QL9GYB3R1BGtk
         7od5WTKxhRxy2Acw9KkJEiWVzDOwvwIFiUC/AB8iwjp7JfW1RZCs4xlWLWDR1FjxgLke
         M591Z1lUYpPdSSLYYnO410FLF0EtsN6lGdt63C9UUkBRpVTGzZkhA7FHgGoQLH64nhYE
         4TN4sZ7sSUfOEGxPEghdLK42n3oInZJDtS+9YXCyhTwnvIOfORoNSJd+Q9z9MJMFkBKH
         dU2w==
X-Gm-Message-State: APjAAAWrZskeUGZ5tgul9ngr5OO90QPFBFnUkeM2ND6uBTsuBlCpqLNC
        6+k/jWUfgH7MLjajTF82NsncQg==
X-Google-Smtp-Source: APXvYqyklEz5e4+IwFGQBrBmCZvd+42WiJ1q+u4q7+b33ayLkLa/ZT1Zr72zVQg0+mStrEfooLIkiQ==
X-Received: by 2002:a37:4bd2:: with SMTP id y201mr41517861qka.391.1571234976882;
        Wed, 16 Oct 2019 07:09:36 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x12sm15910012qtb.32.2019.10.16.07.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:09:36 -0700 (PDT)
Message-ID: <1571234974.5937.53.camel@lca.pw>
Subject: Re: memory leaks in dasd_eckd_check_characteristics() error paths
From:   Qian Cai <cai@lca.pw>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 10:09:34 -0400
In-Reply-To: <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
References: <1570044801.5576.262.camel@lca.pw>
         <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 15:29 +0200, Stefan Haberland wrote:
> Hi,
> 
> thanks for reporting this.
> 
> On 02.10.19 21:33, Qian Cai wrote:
> > For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
> > dasd_generic_set_online() emits this message,
> > 
> > dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12
> > 
> > After that, there are several memory leaks below. There are "config_data" and
> > then stored as,
> > 
> > /* store per path conf_data */
> > device->path[pos].conf_data = conf_data;
> > 
> > When it processes the error path in  dasd_generic_set_online(), it calls
> > dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
> > the device->path[].conf_data first. 
> 
> Usually dasd_delete_device() calls dasd_generic_free_discipline() which
> takes care of
> the device->path[].conf_data in dasd_eckd_uncheck_device().
> From a first look this looks sane.
> 
> So I need to spend a closer look if this does not happen correctly here.

When dasd_eckd_check_characteristics() failed here,

	if (!private) {
		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
		if (!private) {
			dev_warn(&device->cdev->dev,
				 "Allocating memory for private DASD data "
				 "failed\n");
			return -ENOMEM;
		}
		device->private = private;

The device->private is NULL.

Then, in dasd_eckd_uncheck_device(), it will return immediately.

	if (!private)
		return;

> 
> > Is it safe to free those in
> > dasd_free_device() without worrying about the double-free? Or, is it better to
> > free those in dasd_eckd_check_characteristics()'s goto error handling, i.e.,
> > out_err*?
> > 
> > --- a/drivers/s390/block/dasd.c
> > +++ b/drivers/s390/block/dasd.c
> > @@ -153,6 +153,9 @@ struct dasd_device *dasd_alloc_device(void)
> >   */
> >  void dasd_free_device(struct dasd_device *device)
> >  {
> > +       for (int i = 0; i < 8; i++)
> > +               kfree(device->path[i].conf_data);
> > +
> >         kfree(device->private);
> >         free_pages((unsigned long) device->ese_mem, 1);
> >         free_page((unsigned long) device->erp_mem);
> > 
> > 
> > unreferenced object 0x0fcee900 (size 256):
> >   comm "dasdconf.sh", pid 446, jiffies 4294940081 (age 170.340s)
> >   hex dump (first 32 bytes):
> >     dc 01 01 00 f0 f0 f2 f1 f0 f7 f9 f0 f0 c9 c2 d4  ................
> >     f7 f5 f0 f0 f0 f0 f0 f0 f0 c6 d9 c2 f7 f1 62 33  ..............b3
> >   backtrace:
> >     [<00000000a83b1992>] kmem_cache_alloc_trace+0x200/0x388
> >     [<00000000048ef3e2>] dasd_eckd_read_conf+0x408/0x1400 [dasd_eckd_mod]
> >     [<00000000ce31f195>] dasd_eckd_check_characteristics+0x3cc/0x938
> > [dasd_eckd_mod]
> >     [<00000000f6f1759b>] dasd_generic_set_online+0x150/0x4c0
> >     [<00000000efca1efa>] ccw_device_set_online+0x324/0x808
> >     [<00000000f9779774>] online_store_recog_and_online+0xe8/0x220
> >     [<00000000349a5446>] online_store+0x2ce/0x420
> >     [<000000005bd145f8>] kernfs_fop_write+0x1bc/0x270
> >     [<0000000005664197>] vfs_write+0xce/0x220
> >     [<0000000044a8bccb>] ksys_write+0xea/0x190
> >     [<0000000037335938>] system_call+0x296/0x2b4
> 
> 
