Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59800C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C46121850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="E43mdeAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfI0TBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:01:20 -0400
Received: from sonic301-22.consmr.mail.gq1.yahoo.com ([98.137.64.148]:41366
        "EHLO sonic301-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbfI0TBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1569610877; bh=8boG8ajnLNdx3Q6HR+50f0OISCdkUqomEEROs7B0REM=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=E43mdeAEx8XIZE7dRNOmsNYstcUNfkuxB8V1FQ/PIwekMTUghEnkMPovA2mDaP41xYa1CbKoL0nOlZl7e2Kd1JwNHlhRpa7f8W3zLHNpNdFqCiihvp0YwCQGRqC9jwf0kZ2fJvjfwEi9cLnQqjkfGI3Z6XSzTikmwLaGmphzyg//KM7513OS23V/OCOAeFFylet4tZ21SGMsYvexbgIn4VWfgN61YHfWAMj1lElQHKXHnkLvpq3xjSlZu0NZl6fKcBN+VAnoPmHIeQla+++IdHZA59D5LY9uGIUxOFlHxnXbGLN3oDTaKuMCvde1nynso2JxYLo6LW645wlOUdFcQw==
X-YMail-OSG: pCHr9iEVM1k9TM9TPDlnLRCducPSmmLZBpQP9qeUg82P59k1NfAqLn34kyVSgrL
 y9VznNFoFpFn71aXdRBp_40WB.CiCBEIYPdDUU4flDq6eZrVkbhQjxH9RpsoXbNF4oW8uNgTk8K6
 KPUj297axzgIIn5hoGRz9e5u4Iazl0eV.itFbhTUX0V1MFYbeuWVfPo4br9lqNsdfCuTAxcFPYDy
 WyCstAMyLUGMVAmVQDW66kQEJHMSo1AVC7CMbPkxWpfXHH1r4pefu0AyfjThb3Yw8nEAzjVBLpBh
 bMYY9AcQWuZTMeHqAkKPWSt0TL4.UZIqIQxoc5svVA55AhNHuFcU14wJ5zxiBwppH_X9DBFP2Rkn
 QKElhCWvmQ0_D097JIpdKIxXqpKa43.aWAUTIWVmij4ZxR9ZJhy8hbOoPFaJpqaVAbyWvpbDwFVm
 62Vpm9aTZipxDFwNnEovTfyP09ZaulGTvcrgV9Yodrlm9Jp80MwYrs7i.OwV2WVbbLNWsS0.EcY7
 t65KmSSmdz0SGL0W5lUsuMjckRejcChAB.OFH1LlfpFAR1WldmZVl5nl0xUNPrQyjsh.VsHIJ4FB
 z62mjmNnbeQKVw_bdxMUvGeAKG7UIbcqRnSDqyJztYs6y.xU3JXwqVV1RcE3kdStKuO6n2_JhBmZ
 NrYqokMH6DHhQQmWRmEngjngzW1qUBQma.n5O6fQ5KTGZqoF7mjs8fT7ut0FhyCOA7q_Qy4V_dcE
 tOquODj96YyvHxgEKFN7.yghXNgpePYl5sPfmBtsZhPwv_4q.7.79DAwNG3xvQQD6J08Z6ksrf6b
 5Bpw5yhYC6x5o4QNtBqDjED4g4dV5UDyUFOA.85u3ohyVsdWWB8XbPRtp_n9YjFPv5333lJ1A602
 MGGlRXrgRG9x9N7ec4KE_Xiq67lxg0xM47adrMMHxq8rZP_iIHj9CvBJk.fEj.pZBEHpjtvKLFr0
 24hx7UBT0jvES4wFIBEpoYnsFGSTqexwbQhzzvV.UP3Dlr1fdoxc_JcTt58el3Y0HYRm4DtD.bGi
 xevgj4XkAuFt9Kh3tmys.ERqE.4IikUYVMrVLJruVNmpAIVD0kGigPgMtoxXAvXKnhVpY8yqiSAo
 _WREP_t0sRa9aWjF1R1t3Bc_97nndNkLAf8VMRFwYcjjyFkNSyYEAUDwjGzwYoVtAQSt.XI8c_Wg
 vfBquSiJtV2uScilya0toff9qisQEU2loe.L6lMv0XgnZiH1uzQGNUAev7Y7ZJV5I4dC8t5JWHBG
 3Hmecs27pGGvLrVemAJQhn3eTaKpodm3_2jmXFq60dju4hwbnyjHXdsXb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Fri, 27 Sep 2019 19:01:17 +0000
Received: by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41ea480fdb5c16ffe76a1010a62f6533;
          Fri, 27 Sep 2019 19:01:14 +0000 (UTC)
Date:   Sat, 28 Sep 2019 03:01:10 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix comment of f2fs_evict_inode
Message-ID: <20190927190106.GA27964@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190925093050.118921-1-yuchao0@huawei.com>
 <20190927183150.GA54001@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927183150.GA54001@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On Fri, Sep 27, 2019 at 11:31:50AM -0700, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 09/25, Chao Yu wrote:
> > evict() should be called once i_count is zero, rather than i_nlinke
> > is zero.
> > 
> > Reported-by: Gao Xiang <gaoxiang25@huawei.com>
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index db4fec30c30d..8262f4a483d3 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -632,7 +632,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
> >  }
> >  
> >  /*
> > - * Called at the last iput() if i_nlink is zero
> 
> I don't think this comment is wrong. You may be able to add on top of this.

Actually I don't really care what this line means, but someone really
told me that .evict_inode() is called on inode is finally removed
because he saw this line.

In practice, I have no idea what the above line (especially the word i_nlink
== 0) mainly emphasizes, just from some documentation (not even refer some code):

Documentation/filesystems/porting.rst
326 **mandatory**
327 
328 ->clear_inode() and ->delete_inode() are gone; ->evict_inode() should
329 be used instead.  It gets called whenever the inode is evicted, whether it has
330 remaining links or not. 

And it seems it's the same comment exists in ext2/ext4. But yes, it's up
to you. However, it misleaded someone and I had to explain more about this.

Thanks,
Gao Xiang

> 
> > + * Called at the last iput() if i_count is zero
> >   */
> >  void f2fs_evict_inode(struct inode *inode)
> >  {
> > -- 
> > 2.18.0.rc1
