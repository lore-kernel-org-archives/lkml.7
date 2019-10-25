Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7389A206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572029243;
	bh=k6w0LvvFLl0dAuPN+bqEbE/a+SxzCpqH+9oqyhdwoDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ojJ9KEddTeL8nP1vzf8um8IXKrJci7u06gDaIGgE2243jpzGGxvbQSofZq//7pmN+
	 FPVplC/UW+M7m9bJbvQoewn1JGfiko4weHwlUpr2C2lplJoHxYBfWo4jdZWptjCS/4
	 7PFkHww+fmmomEFrW+B/Ed+VDa84+24VknPSwvJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfJYSrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:47:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37777 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfJYSrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:47:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so2708139qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/M+uzGAXKE7aNZf/aE+ISjtvpFCa1I0KSq2UGW6xEyA=;
        b=q4geg7q8KjM2M9vfuDzhpHWm13FVvbDbRgP4VGdG/knhGLY7fsTXIsksgDURkfaa+B
         N2yM6sfaGlS8B1k41DgMyU/BKUPS1T9whtxOaJLfNXpcCB8SMCenRWHBaGyB9S626QVB
         bOoWYxRQJ2yY2fX7eooKICpD9PdDLQcVom+EhsFXh4rqm/4x5fskyqf0BzGWauiH3ELs
         e4t6p48a7pdEmTy20q2AH9jeZBWHCyJbP4VFj2iCONGH6BvEJx8phG5lhHaAS9cMpZY6
         Ge8vEVnZn+4fU8zhtBPCFcbuzt6OD5c7bHs4ZgwxTo7euGf6E+cN5L5ec83XD8tYmMKk
         jQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/M+uzGAXKE7aNZf/aE+ISjtvpFCa1I0KSq2UGW6xEyA=;
        b=HbE0ADp0JDS+az68UucIU/YfEt0YIB2NGvMDXmvcwr6OiNAPPZ+NCn/Kg2kFi60ZH4
         72ObjfWMnfn5ow6LcJXVwEDwXyLXu24UMYi2bav0X2zNsmvlng92nOcFIjkGBPqVobi1
         REjKbyB6PsoHE1ykMzSgGiejb26Xjly107I6gp0sK4IxtGT0CIbiLHkE/MBh7xp2UEAw
         AvqT/2/rmgVxVZlW38+TXTLxbSFAXzStO1jIVBYb2CQTgSIY1OJisaAbSRTu2IryUJtx
         WdigqlGtnxJhjzzQ61NLJyEqJy7gMrqWELdUVzmHHS90J4iVinzKHlS2Y59izSGmkjd3
         vo4w==
X-Gm-Message-State: APjAAAUm2LRR1gFokHeM+/5F8UC4mzf1m1bunl8Bqo0ed+nW+bXbDJ7F
        63zbFdnOd34ltTHbXavlSG8=
X-Google-Smtp-Source: APXvYqwLwf3+8hRS4pXBCInLc4Ntd0vmmCTdkbVlJLOchV4sDTWBVOOq3SEgR2Zu2kbMGgQJP7cQ0g==
X-Received: by 2002:a37:a796:: with SMTP id q144mr4219557qke.494.1572029238246;
        Fri, 25 Oct 2019 11:47:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fd3c])
        by smtp.gmail.com with ESMTPSA id k29sm1687094qtu.70.2019.10.25.11.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 11:47:17 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:47:14 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Add generation number with cgroup id
Message-ID: <20191025184714.GJ3622521@devbig004.ftw2.facebook.com>
References: <20191016125019.157144-1-namhyung@kernel.org>
 <20191016125019.157144-2-namhyung@kernel.org>
 <20191024174433.GA3622521@devbig004.ftw2.facebook.com>
 <CAM9d7chWpj105TYR0qP3T8FJ=-2wjp+sh6Rk8zkvJb_ugtL3Dw@mail.gmail.com>
 <20191025110623.GH3622521@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025110623.GH3622521@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 04:06:23AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Fri, Oct 25, 2019 at 05:30:35PM +0900, Namhyung Kim wrote:
> > > Any chance I can persuade you into making this conversion?  idr is
> > > exactly the wrong data structure to use for cyclic allocations.  We've
> > > been doing it mostly for historical reasons but I really hope we can
> > > move away from it.  These lookups aren't in super hot paths and doing
> > > locked lookups should be fine.
> > 
> > As you know, it entails change in kernfs id and its users.
> > And I really want to finish the perf cgroup sampling work first.
> > Can I work on this after the perf work is done?
> 
> Sure, but I think we should get the userland visible behaviors right.
> Ignoring implementation details:
> 
> * cgroup vs. css IDs doesn't matter for now.  css IDs aren't visible
>   to userland anyway and it could be that keeping using idr as-is or
>   always using 64bit IDs is the better solution for them.
> 
> * On 32bit ino setups, 32bit ino + gen as cgroup and export fs IDs.
> 
> * On 64bit ino setups, 64bit unique ino (allocated whichever way) + 0
>   gen as cgroup and export fs IDs.

So, something like the following.  Just to show the direction.  Only
compile tested and full of holes.  I'll see if I can get it working
over the weekend.


Index: work/include/trace/events/writeback.h
===================================================================
--- work.orig/include/trace/events/writeback.h
+++ work/include/trace/events/writeback.h
@@ -61,7 +61,7 @@ DECLARE_EVENT_CLASS(writeback_page_templ
 
 	TP_STRUCT__entry (
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(pgoff_t, index)
 	),
 
@@ -102,7 +102,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inod
 
 	TP_STRUCT__entry (
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(unsigned long, state)
 		__field(unsigned long, flags)
 	),
@@ -150,28 +150,28 @@ DEFINE_EVENT(writeback_dirty_inode_templ
 #ifdef CREATE_TRACE_POINTS
 #ifdef CONFIG_CGROUP_WRITEBACK
 
-static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
+static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
 {
-	return wb->memcg_css->cgroup->kn->id.ino;
+	return cgroup_ino(wb->memcg_css->cgroup);
 }
 
-static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
+static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 {
 	if (wbc->wb)
 		return __trace_wb_assign_cgroup(wbc->wb);
 	else
-		return -1U;
+		return 0;
 }
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
-static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
+static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
 {
-	return -1U;
+	return 0;
 }
 
-static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
+static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 {
-	return -1U;
+	return 0;
 }
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
@@ -187,8 +187,8 @@ TRACE_EVENT(inode_foreign_history,
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
-		__field(unsigned long,	ino)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		ino)
+		__field(ino_t,		cgroup_ino)
 		__field(unsigned int,	history)
 	),
 
@@ -199,7 +199,7 @@ TRACE_EVENT(inode_foreign_history,
 		__entry->history	= history;
 	),
 
-	TP_printk("bdi %s: ino=%lu cgroup_ino=%u history=0x%x",
+	TP_printk("bdi %s: ino=%lu cgroup_ino=%lu history=0x%x",
 		__entry->name,
 		__entry->ino,
 		__entry->cgroup_ino,
@@ -216,9 +216,9 @@ TRACE_EVENT(inode_switch_wbs,
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
-		__field(unsigned long,	ino)
-		__field(unsigned int,	old_cgroup_ino)
-		__field(unsigned int,	new_cgroup_ino)
+		__field(ino_t,		ino)
+		__field(ino_t,		old_cgroup_ino)
+		__field(ino_t,		new_cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -228,7 +228,7 @@ TRACE_EVENT(inode_switch_wbs,
 		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
 	),
 
-	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%u new_cgroup_ino=%u",
+	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%lu new_cgroup_ino=%lu",
 		__entry->name,
 		__entry->ino,
 		__entry->old_cgroup_ino,
@@ -245,10 +245,10 @@ TRACE_EVENT(track_foreign_dirty,
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
 		__field(u64,		bdi_id)
-		__field(unsigned long,	ino)
+		__field(ino_t,		ino)
 		__field(unsigned int,	memcg_id)
-		__field(unsigned int,	cgroup_ino)
-		__field(unsigned int,	page_cgroup_ino)
+		__field(ino_t,		cgroup_ino)
+		__field(ino_t,		page_cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -260,10 +260,10 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
-		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
+		__entry->page_cgroup_ino = cgroup_ino(page->mem_cgroup->css.cgroup);
 	),
 
-	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%u page_cgroup_ino=%u",
+	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
 		__entry->name,
 		__entry->bdi_id,
 		__entry->ino,
@@ -282,7 +282,7 @@ TRACE_EVENT(flush_foreign,
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		cgroup_ino)
 		__field(unsigned int,	frn_bdi_id)
 		__field(unsigned int,	frn_memcg_id)
 	),
@@ -294,7 +294,7 @@ TRACE_EVENT(flush_foreign,
 		__entry->frn_memcg_id	= frn_memcg_id;
 	),
 
-	TP_printk("bdi %s: cgroup_ino=%u frn_bdi_id=%u frn_memcg_id=%u",
+	TP_printk("bdi %s: cgroup_ino=%lu frn_bdi_id=%u frn_memcg_id=%u",
 		__entry->name,
 		__entry->cgroup_ino,
 		__entry->frn_bdi_id,
@@ -311,9 +311,9 @@ DECLARE_EVENT_CLASS(writeback_write_inod
 
 	TP_STRUCT__entry (
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(int, sync_mode)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -324,7 +324,7 @@ DECLARE_EVENT_CLASS(writeback_write_inod
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 	),
 
-	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%u",
+	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%lu",
 		__entry->name,
 		__entry->ino,
 		__entry->sync_mode,
@@ -358,7 +358,7 @@ DECLARE_EVENT_CLASS(writeback_work_class
 		__field(int, range_cyclic)
 		__field(int, for_background)
 		__field(int, reason)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 	TP_fast_assign(
 		strscpy_pad(__entry->name,
@@ -374,7 +374,7 @@ DECLARE_EVENT_CLASS(writeback_work_class
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: sb_dev %d:%d nr_pages=%ld sync_mode=%d "
-		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%u",
+		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%lu",
 		  __entry->name,
 		  MAJOR(__entry->sb_dev), MINOR(__entry->sb_dev),
 		  __entry->nr_pages,
@@ -413,13 +413,13 @@ DECLARE_EVENT_CLASS(writeback_class,
 	TP_ARGS(wb),
 	TP_STRUCT__entry(
 		__array(char, name, 32)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 	TP_fast_assign(
 		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
-	TP_printk("bdi %s: cgroup_ino=%u",
+	TP_printk("bdi %s: cgroup_ino=%lu",
 		  __entry->name,
 		  __entry->cgroup_ino
 	)
@@ -459,7 +459,7 @@ DECLARE_EVENT_CLASS(wbc_class,
 		__field(int, range_cyclic)
 		__field(long, range_start)
 		__field(long, range_end)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -478,7 +478,7 @@ DECLARE_EVENT_CLASS(wbc_class,
 
 	TP_printk("bdi %s: towrt=%ld skip=%ld mode=%d kupd=%d "
 		"bgrd=%d reclm=%d cyclic=%d "
-		"start=0x%lx end=0x%lx cgroup_ino=%u",
+		"start=0x%lx end=0x%lx cgroup_ino=%lu",
 		__entry->name,
 		__entry->nr_to_write,
 		__entry->pages_skipped,
@@ -510,7 +510,7 @@ TRACE_EVENT(writeback_queue_io,
 		__field(long,		age)
 		__field(int,		moved)
 		__field(int,		reason)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		cgroup_ino)
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
@@ -522,7 +522,7 @@ TRACE_EVENT(writeback_queue_io,
 		__entry->reason	= work->reason;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 	),
-	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%u",
+	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%lu",
 		__entry->name,
 		__entry->older,	/* older_than_this in jiffies */
 		__entry->age,	/* older_than_this in relative milliseconds */
@@ -596,7 +596,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 		__field(unsigned long,	dirty_ratelimit)
 		__field(unsigned long,	task_ratelimit)
 		__field(unsigned long,	balanced_dirty_ratelimit)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -614,7 +614,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 	TP_printk("bdi %s: "
 		  "write_bw=%lu awrite_bw=%lu dirty_rate=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
-		  "balanced_dirty_ratelimit=%lu cgroup_ino=%u",
+		  "balanced_dirty_ratelimit=%lu cgroup_ino=%lu",
 		  __entry->bdi,
 		  __entry->write_bw,		/* write bandwidth */
 		  __entry->avg_write_bw,	/* avg write bandwidth */
@@ -660,7 +660,7 @@ TRACE_EVENT(balance_dirty_pages,
 		__field(	 long,	pause)
 		__field(unsigned long,	period)
 		__field(	 long,	think)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -692,7 +692,7 @@ TRACE_EVENT(balance_dirty_pages,
 		  "bdi_setpoint=%lu bdi_dirty=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
 		  "dirtied=%u dirtied_pause=%u "
-		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%u",
+		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
 		  __entry->bdi,
 		  __entry->limit,
 		  __entry->setpoint,
@@ -718,10 +718,10 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 
 	TP_STRUCT__entry(
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -733,7 +733,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
 	),
 
-	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%u",
+	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%lu",
 		  __entry->name,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
@@ -789,13 +789,13 @@ DECLARE_EVENT_CLASS(writeback_single_ino
 
 	TP_STRUCT__entry(
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
 		__field(unsigned long, writeback_index)
 		__field(long, nr_to_write)
 		__field(unsigned long, wrote)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -811,7 +811,7 @@ DECLARE_EVENT_CLASS(writeback_single_ino
 	),
 
 	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu "
-		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%u",
+		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%lu",
 		  __entry->name,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
@@ -845,7 +845,7 @@ DECLARE_EVENT_CLASS(writeback_inode_temp
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(unsigned long,	ino			)
+		__field(	ino_t,	ino			)
 		__field(unsigned long,	state			)
 		__field(	__u16, mode			)
 		__field(unsigned long, dirtied_when		)
Index: work/fs/kernfs/dir.c
===================================================================
--- work.orig/fs/kernfs/dir.c
+++ work/fs/kernfs/dir.c
@@ -509,7 +509,7 @@ void kernfs_put(struct kernfs_node *kn)
 	struct kernfs_root *root;
 
 	/*
-	 * kernfs_node is freed with ->count 0, kernfs_find_and_get_node_by_ino
+	 * kernfs_node is freed with ->count 0, kernfs_find_and_get_node_by_id
 	 * depends on this to filter reused stale node
 	 */
 	if (!kn || !atomic_dec_and_test(&kn->count))
@@ -536,7 +536,7 @@ void kernfs_put(struct kernfs_node *kn)
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
 	spin_lock(&kernfs_idr_lock);
-	idr_remove(&root->ino_idr, kn->id.ino);
+	idr_remove(&root->ino_idr, kernfs_ino(kn));
 	spin_unlock(&kernfs_idr_lock);
 	kmem_cache_free(kernfs_node_cache, kn);
 
@@ -644,12 +644,12 @@ static struct kernfs_node *__kernfs_new_
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
-	kn->id.ino = ret;
-	kn->id.generation = gen;
+
+	kn->id = (u64)gen << 32 | ret;
 
 	/*
 	 * set ino first. This RELEASE is paired with atomic_inc_not_zero in
-	 * kernfs_find_and_get_node_by_ino
+	 * kernfs_find_and_get_node_by_id
 	 */
 	atomic_set_release(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
@@ -680,7 +680,7 @@ static struct kernfs_node *__kernfs_new_
 	return kn;
 
  err_out3:
-	idr_remove(&root->ino_idr, kn->id.ino);
+	idr_remove(&root->ino_idr, kernfs_ino(kn));
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
@@ -705,20 +705,25 @@ struct kernfs_node *kernfs_new_node(stru
 }
 
 /*
- * kernfs_find_and_get_node_by_ino - get kernfs_node from inode number
+ * kernfs_find_and_get_node_by_id - get kernfs_node from node id
  * @root: the kernfs root
- * @ino: inode number
+ * @id: the target node id
+ *
+ * @id's lower 32bits encode ino and upper gen.  If the gen portion is
+ * zero, all generations are matched.
  *
  * RETURNS:
  * NULL on failure. Return a kernfs node with reference counter incremented
  */
-struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
-						    unsigned int ino)
+struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
+						   u64 id)
 {
 	struct kernfs_node *kn;
+	ino_t ino = kernfs_id_ino(id);
+	u32 gen = kernfs_id_gen(id);
 
 	rcu_read_lock();
-	kn = idr_find(&root->ino_idr, ino);
+	kn = idr_find(&root->ino_idr, (u32)ino);
 	if (!kn)
 		goto out;
 
@@ -741,8 +746,13 @@ struct kernfs_node *kernfs_find_and_get_
 	 * before 'count'. So if 'count' is uptodate, 'ino' should be uptodate,
 	 * hence we can use 'ino' to filter stale node.
 	 */
-	if (kn->id.ino != ino)
+	if (kernfs_ino(kn) != ino)
 		goto out;
+
+	/* if upper 32bit of @id was zero, ignore gen */
+	if (gen && kernfs_gen(kn) != gen)
+		goto out;
+
 	rcu_read_unlock();
 
 	return kn;
@@ -1678,7 +1688,7 @@ static int kernfs_fop_readdir(struct fil
 		const char *name = pos->name;
 		unsigned int type = dt_type(pos);
 		int len = strlen(name);
-		ino_t ino = pos->id.ino;
+		ino_t ino = kernfs_ino(pos);
 
 		ctx->pos = pos->hash;
 		file->private_data = pos;
Index: work/fs/kernfs/file.c
===================================================================
--- work.orig/fs/kernfs/file.c
+++ work/fs/kernfs/file.c
@@ -892,7 +892,7 @@ repeat:
 		 * have the matching @file available.  Look up the inodes
 		 * and generate the events manually.
 		 */
-		inode = ilookup(info->sb, kn->id.ino);
+		inode = ilookup(info->sb, kernfs_ino(kn));
 		if (!inode)
 			continue;
 
@@ -901,7 +901,7 @@ repeat:
 		if (parent) {
 			struct inode *p_inode;
 
-			p_inode = ilookup(info->sb, parent->id.ino);
+			p_inode = ilookup(info->sb, kernfs_ino(parent));
 			if (p_inode) {
 				fsnotify(p_inode, FS_MODIFY | FS_EVENT_ON_CHILD,
 					 inode, FSNOTIFY_EVENT_INODE, &name, 0);
Index: work/fs/kernfs/inode.c
===================================================================
--- work.orig/fs/kernfs/inode.c
+++ work/fs/kernfs/inode.c
@@ -201,7 +201,7 @@ static void kernfs_init_inode(struct ker
 	inode->i_private = kn;
 	inode->i_mapping->a_ops = &kernfs_aops;
 	inode->i_op = &kernfs_iops;
-	inode->i_generation = kn->id.generation;
+	inode->i_generation = kernfs_gen(kn);
 
 	set_default_inode_attr(inode, kn->mode);
 	kernfs_refresh_inode(kn, inode);
@@ -247,7 +247,7 @@ struct inode *kernfs_get_inode(struct su
 {
 	struct inode *inode;
 
-	inode = iget_locked(sb, kn->id.ino);
+	inode = iget_locked(sb, kernfs_ino(kn));
 	if (inode && (inode->i_state & I_NEW))
 		kernfs_init_inode(kn, inode);
 
Index: work/fs/kernfs/kernfs-internal.h
===================================================================
--- work.orig/fs/kernfs/kernfs-internal.h
+++ work/fs/kernfs/kernfs-internal.h
@@ -109,8 +109,6 @@ struct kernfs_node *kernfs_new_node(stru
 				    const char *name, umode_t mode,
 				    kuid_t uid, kgid_t gid,
 				    unsigned flags);
-struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
-						    unsigned int ino);
 
 /*
  * file.c
Index: work/fs/kernfs/mount.c
===================================================================
--- work.orig/fs/kernfs/mount.c
+++ work/fs/kernfs/mount.c
@@ -53,63 +53,82 @@ const struct super_operations kernfs_sop
 	.show_path	= kernfs_sop_show_path,
 };
 
-/*
- * Similar to kernfs_fh_get_inode, this one gets kernfs node from inode
- * number and generation
- */
-struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root,
-	const union kernfs_node_id *id)
+static int kernfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
+			    struct inode *parent)
 {
-	struct kernfs_node *kn;
+	struct kernfs_node *kn = inode->i_private;
 
-	kn = kernfs_find_and_get_node_by_ino(root, id->ino);
-	if (!kn)
-		return NULL;
-	if (kn->id.generation != id->generation) {
-		kernfs_put(kn);
-		return NULL;
+	if (*max_len < 2) {
+		*max_len = 2;
+		return FILEID_INVALID;
 	}
-	return kn;
+
+	*max_len = 2;
+	*(u64 *)fh = kn->id;
+	return FILEID_KERNFS;
 }
 
-static struct inode *kernfs_fh_get_inode(struct super_block *sb,
-		u64 ino, u32 generation)
+static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
+					    struct fid *fid, int fh_len,
+					    int fh_type, bool get_parent)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct inode *inode;
 	struct kernfs_node *kn;
+	struct inode *inode;
+	u64 id;
 
-	if (ino == 0)
-		return ERR_PTR(-ESTALE);
+	if (fh_len < 2)
+		return NULL;
 
-	kn = kernfs_find_and_get_node_by_ino(info->root, ino);
+	/*
+	 * We used to use the generic types and blktrace exposes the
+	 * numbers without specifying the type.  Accept the generic types
+	 * for compatibility.
+	 */
+	switch (fh_type) {
+	case FILEID_KERNFS:
+		id = *(u64 *)fid;
+		break;
+	case FILEID_INO32_GEN:
+	case FILEID_INO32_GEN_PARENT:
+		id = ((u64)fid->i32.gen << 32) | fid->i32.ino;
+		break;
+	default:
+		return NULL;
+	}
+
+	kn = kernfs_find_and_get_node_by_id(info->root, id);
 	if (!kn)
 		return ERR_PTR(-ESTALE);
+
+	if (get_parent) {
+		struct kernfs_node *parent;
+
+		parent = kernfs_get_parent(kn);
+		kernfs_put(kn);
+		kn = parent;
+	}
+
 	inode = kernfs_get_inode(sb, kn);
 	kernfs_put(kn);
 	if (!inode)
 		return ERR_PTR(-ESTALE);
 
-	if (generation && inode->i_generation != generation) {
-		/* we didn't find the right inode.. */
-		iput(inode);
-		return ERR_PTR(-ESTALE);
-	}
-	return inode;
+	return d_obtain_alias(inode);
 }
 
-static struct dentry *kernfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
-		int fh_len, int fh_type)
+static struct dentry *kernfs_fh_to_dentry(struct super_block *sb,
+					  struct fid *fid, int fh_len,
+					  int fh_type)
 {
-	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
-				    kernfs_fh_get_inode);
+	return __kernfs_fh_to_dentry(sb, fid, fh_len, fh_type, false);
 }
 
-static struct dentry *kernfs_fh_to_parent(struct super_block *sb, struct fid *fid,
-		int fh_len, int fh_type)
+static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
+					  struct fid *fid, int fh_len,
+					  int fh_type)
 {
-	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
-				    kernfs_fh_get_inode);
+	return __kernfs_fh_to_dentry(sb, fid, fh_len, fh_type, true);
 }
 
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
@@ -120,6 +139,7 @@ static struct dentry *kernfs_get_parent_
 }
 
 static const struct export_operations kernfs_export_ops = {
+	.encode_fh	= kernfs_encode_fh,
 	.fh_to_dentry	= kernfs_fh_to_dentry,
 	.fh_to_parent	= kernfs_fh_to_parent,
 	.get_parent	= kernfs_get_parent_dentry,
@@ -365,9 +385,9 @@ void __init kernfs_init(void)
 {
 
 	/*
-	 * the slab is freed in RCU context, so kernfs_find_and_get_node_by_ino
+	 * the slab is freed in RCU context, so kernfs_find_and_get_node_by_id
 	 * can access the slab lock free. This could introduce stale nodes,
-	 * please see how kernfs_find_and_get_node_by_ino filters out stale
+	 * please see how kernfs_find_and_get_node_by_id filters out stale
 	 * nodes.
 	 */
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
Index: work/include/linux/cgroup.h
===================================================================
--- work.orig/include/linux/cgroup.h
+++ work/include/linux/cgroup.h
@@ -616,7 +616,7 @@ static inline bool cgroup_is_populated(s
 /* returns ino associated with a cgroup */
 static inline ino_t cgroup_ino(struct cgroup *cgrp)
 {
-	return cgrp->kn->id.ino;
+	return kernfs_ino(cgrp->kn);
 }
 
 /* cft/css accessors for cftype->write() operation */
@@ -687,13 +687,12 @@ static inline void cgroup_kthread_ready(
 	current->no_cgroup_migration = 0;
 }
 
-static inline union kernfs_node_id *cgroup_get_kernfs_id(struct cgroup *cgrp)
+static inline u64 cgroup_get_kernfs_id(struct cgroup *cgrp)
 {
-	return &cgrp->kn->id;
+	return cgrp->kn->id;
 }
 
-void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
-					char *buf, size_t buflen);
+void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -718,9 +717,9 @@ static inline int cgroup_init_early(void
 static inline int cgroup_init(void) { return 0; }
 static inline void cgroup_init_kthreadd(void) {}
 static inline void cgroup_kthread_ready(void) {}
-static inline union kernfs_node_id *cgroup_get_kernfs_id(struct cgroup *cgrp)
+static inline union u64 cgroup_get_kernfs_id(struct cgroup *cgrp)
 {
-	return NULL;
+	return 0;
 }
 
 static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
@@ -739,8 +738,8 @@ static inline bool task_under_cgroup_hie
 	return true;
 }
 
-static inline void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
-	char *buf, size_t buflen) {}
+static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
+{}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
Index: work/include/linux/kernfs.h
===================================================================
--- work.orig/include/linux/kernfs.h
+++ work/include/linux/kernfs.h
@@ -104,21 +104,6 @@ struct kernfs_elem_attr {
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
 };
 
-/* represent a kernfs node */
-union kernfs_node_id {
-	struct {
-		/*
-		 * blktrace will export this struct as a simplified 'struct
-		 * fid' (which is a big data struction), so userspace can use
-		 * it to find kernfs node. The layout must match the first two
-		 * fields of 'struct fid' exactly.
-		 */
-		u32		ino;
-		u32		generation;
-	};
-	u64			id;
-};
-
 /*
  * kernfs_node - the building block of kernfs hierarchy.  Each and every
  * kernfs node is represented by single kernfs_node.  Most fields are
@@ -155,7 +140,7 @@ struct kernfs_node {
 
 	void			*priv;
 
-	union kernfs_node_id	id;
+	u64			id;
 	unsigned short		flags;
 	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
@@ -291,6 +276,32 @@ static inline enum kernfs_node_type kern
 	return kn->flags & KERNFS_TYPE_MASK;
 }
 
+static inline ino_t kernfs_id_ino(u64 id)
+{
+	if (sizeof(ino_t) >= sizeof(u64))
+		return id;
+	else
+		return (u32)id;
+}
+
+static inline u32 kernfs_id_gen(u64 id)
+{
+	if (sizeof(ino_t) >= sizeof(u64))
+		return 0;
+	else
+		return id >> 32;
+}
+
+static inline ino_t kernfs_ino(struct kernfs_node *kn)
+{
+	return kernfs_id_ino(kn->id);
+}
+
+static inline ino_t kernfs_gen(struct kernfs_node *kn)
+{
+	return kernfs_id_gen(kn->id);
+}
+
 /**
  * kernfs_enable_ns - enable namespace under a directory
  * @kn: directory of interest, should be empty
@@ -382,8 +393,8 @@ void kernfs_kill_sb(struct super_block *
 
 void kernfs_init(void);
 
-struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root,
-	const union kernfs_node_id *id);
+struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
+						   u64 id);
 #else	/* CONFIG_KERNFS */
 
 static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
Index: work/kernel/cgroup/cgroup.c
===================================================================
--- work.orig/kernel/cgroup/cgroup.c
+++ work/kernel/cgroup/cgroup.c
@@ -1308,10 +1308,7 @@ static void cgroup_exit_root_id(struct c
 
 void cgroup_free_root(struct cgroup_root *root)
 {
-	if (root) {
-		idr_destroy(&root->cgroup_idr);
-		kfree(root);
-	}
+	kfree(root);
 }
 
 static void cgroup_destroy_root(struct cgroup_root *root)
@@ -1917,7 +1914,6 @@ void init_cgroup_root(struct cgroup_fs_c
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
-	idr_init(&root->cgroup_idr);
 
 	root->flags = ctx->flags;
 	if (ctx->release_agent)
@@ -1938,12 +1934,6 @@ int cgroup_setup_root(struct cgroup_root
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	ret = cgroup_idr_alloc(&root->cgroup_idr, root_cgrp, 1, 2, GFP_KERNEL);
-	if (ret < 0)
-		goto out;
-	root_cgrp->id = ret;
-	root_cgrp->ancestor_ids[0] = ret;
-
 	ret = percpu_ref_init(&root_cgrp->self.refcnt, css_release,
 			      0, GFP_KERNEL);
 	if (ret)
@@ -1976,6 +1966,8 @@ int cgroup_setup_root(struct cgroup_root
 		goto exit_root_id;
 	}
 	root_cgrp->kn = root->kf_root->kn;
+	root_cgrp->id = root_cgrp->kn->id;
+	root_cgrp->ancestor_ids[0] = root_cgrp->id;
 
 	ret = css_populate_dir(&root_cgrp->self);
 	if (ret)
@@ -4987,7 +4979,6 @@ static void css_release_work_fn(struct w
 			tcgrp->nr_dying_descendants--;
 		spin_unlock_irq(&css_set_lock);
 
-		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
 		cgrp->id = -1;
 
 		/*
@@ -5154,10 +5145,12 @@ err_free_css:
  * it isn't associated with its kernfs_node and doesn't have the control
  * mask applied.
  */
-static struct cgroup *cgroup_create(struct cgroup *parent)
+static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
+				    umode_t mode)
 {
 	struct cgroup_root *root = parent->root;
 	struct cgroup *cgrp, *tcgrp;
+	struct kernfs_node *kn;
 	int level = parent->level + 1;
 	int ret;
 
@@ -5177,15 +5170,14 @@ static struct cgroup *cgroup_create(stru
 			goto out_cancel_ref;
 	}
 
-	/*
-	 * Temporarily set the pointer to NULL, so idr_find() won't return
-	 * a half-baked cgroup.
-	 */
-	cgrp->id = cgroup_idr_alloc(&root->cgroup_idr, NULL, 2, 0, GFP_KERNEL);
-	if (cgrp->id < 0) {
-		ret = -ENOMEM;
+	/* create the directory */
+	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
+	if (IS_ERR(kn)) {
+		ret = PTR_ERR(kn);
 		goto out_stat_exit;
 	}
+	cgrp->kn = kn;
+	cgrp->id = kn->id;
 
 	init_cgroup_housekeeping(cgrp);
 
@@ -5195,11 +5187,11 @@ static struct cgroup *cgroup_create(stru
 
 	ret = psi_cgroup_alloc(cgrp);
 	if (ret)
-		goto out_idr_free;
+		goto out_kernfs_remove;
 
 	ret = cgroup_bpf_inherit(cgrp);
 	if (ret)
-		goto out_psi_free;
+		goto out_kernfs_remove;
 
 	/*
 	 * New cgroup inherits effective freeze counter, and
@@ -5249,12 +5241,6 @@ static struct cgroup *cgroup_create(stru
 	cgroup_get_live(parent);
 
 	/*
-	 * @cgrp is now fully operational.  If something fails after this
-	 * point, it'll be released via the normal destruction path.
-	 */
-	cgroup_idr_replace(&root->cgroup_idr, cgrp, cgrp->id);
-
-	/*
 	 * On the default hierarchy, a child doesn't automatically inherit
 	 * subtree_control from the parent.  Each is configured manually.
 	 */
@@ -5265,10 +5251,8 @@ static struct cgroup *cgroup_create(stru
 
 	return cgrp;
 
-out_psi_free:
-	psi_cgroup_free(cgrp);
-out_idr_free:
-	cgroup_idr_remove(&root->cgroup_idr, cgrp->id);
+out_kernfs_remove:
+	kernfs_remove(cgrp->kn);
 out_stat_exit:
 	if (cgroup_on_dfl(parent))
 		cgroup_rstat_exit(cgrp);
@@ -5305,7 +5289,6 @@ fail:
 int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 {
 	struct cgroup *parent, *cgrp;
-	struct kernfs_node *kn;
 	int ret;
 
 	/* do not accept '\n' to prevent making /proc/<pid>/cgroup unparsable */
@@ -5321,27 +5304,19 @@ int cgroup_mkdir(struct kernfs_node *par
 		goto out_unlock;
 	}
 
-	cgrp = cgroup_create(parent);
+	cgrp = cgroup_create(parent, name, mode);
 	if (IS_ERR(cgrp)) {
 		ret = PTR_ERR(cgrp);
 		goto out_unlock;
 	}
 
-	/* create the directory */
-	kn = kernfs_create_dir(parent->kn, name, mode, cgrp);
-	if (IS_ERR(kn)) {
-		ret = PTR_ERR(kn);
-		goto out_destroy;
-	}
-	cgrp->kn = kn;
-
 	/*
 	 * This extra ref will be put in cgroup_free_fn() and guarantees
 	 * that @cgrp->kn is always accessible.
 	 */
-	kernfs_get(kn);
+	kernfs_get(cgrp->kn);
 
-	ret = cgroup_kn_set_ugid(kn);
+	ret = cgroup_kn_set_ugid(cgrp->kn);
 	if (ret)
 		goto out_destroy;
 
@@ -5356,7 +5331,7 @@ int cgroup_mkdir(struct kernfs_node *par
 	TRACE_CGROUP_PATH(mkdir, cgrp);
 
 	/* let's create and online css's */
-	kernfs_activate(kn);
+	kernfs_activate(cgrp->kn);
 
 	ret = 0;
 	goto out_unlock;
@@ -5786,12 +5761,11 @@ static int __init cgroup_wq_init(void)
 }
 core_initcall(cgroup_wq_init);
 
-void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
-					char *buf, size_t buflen)
+void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 {
 	struct kernfs_node *kn;
 
-	kn = kernfs_get_node_by_id(cgrp_dfl_root.kf_root, id);
+	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
 	if (!kn)
 		return;
 	kernfs_path(kn, buf, buflen);
Index: work/kernel/trace/blktrace.c
===================================================================
--- work.orig/kernel/trace/blktrace.c
+++ work/kernel/trace/blktrace.c
@@ -64,8 +64,7 @@ static void blk_unregister_tracepoints(v
  * Send out a notify message.
  */
 static void trace_note(struct blk_trace *bt, pid_t pid, int action,
-		       const void *data, size_t len,
-		       union kernfs_node_id *cgid)
+		       const void *data, size_t len, u64 cgid)
 {
 	struct blk_io_trace *t;
 	struct ring_buffer_event *event = NULL;
@@ -73,7 +72,7 @@ static void trace_note(struct blk_trace
 	int pc = 0;
 	int cpu = smp_processor_id();
 	bool blk_tracer = blk_tracer_enabled;
-	ssize_t cgid_len = cgid ? sizeof(*cgid) : 0;
+	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
 
 	if (blk_tracer) {
 		buffer = blk_tr->trace_buffer.buffer;
@@ -100,9 +99,9 @@ record_it:
 		t->pid = pid;
 		t->cpu = cpu;
 		t->pdu_len = len + cgid_len;
-		if (cgid)
-			memcpy((void *)t + sizeof(*t), cgid, cgid_len);
-		memcpy((void *) t + sizeof(*t) + cgid_len, data, len);
+		if (cgid_len)
+			*(u64 *)(t + 1) = cgid;
+		memcpy((void *)( t + sizeof(*t)) + cgid_len, data, len);
 
 		if (blk_tracer)
 			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
@@ -122,7 +121,7 @@ static void trace_note_tsk(struct task_s
 	spin_lock_irqsave(&running_trace_lock, flags);
 	list_for_each_entry(bt, &running_trace_list, running_list) {
 		trace_note(bt, tsk->pid, BLK_TN_PROCESS, tsk->comm,
-			   sizeof(tsk->comm), NULL);
+			   sizeof(tsk->comm), 0);
 	}
 	spin_unlock_irqrestore(&running_trace_lock, flags);
 }
@@ -139,7 +138,7 @@ static void trace_note_time(struct blk_t
 	words[1] = now.tv_nsec;
 
 	local_irq_save(flags);
-	trace_note(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), NULL);
+	trace_note(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0);
 	local_irq_restore(flags);
 }
 
@@ -172,9 +171,9 @@ void __trace_note_message(struct blk_tra
 		blkcg = NULL;
 #ifdef CONFIG_BLK_CGROUP
 	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n,
-		blkcg ? cgroup_get_kernfs_id(blkcg->css.cgroup) : NULL);
+		blkcg ? cgroup_get_kernfs_id(blkcg->css.cgroup) : 0);
 #else
-	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n, NULL);
+	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n, 0);
 #endif
 	local_irq_restore(flags);
 }
@@ -212,7 +211,7 @@ static const u32 ddir_act[2] = { BLK_TC_
  */
 static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		     int op, int op_flags, u32 what, int error, int pdu_len,
-		     void *pdu_data, union kernfs_node_id *cgid)
+		     void *pdu_data, u64 cgid)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -223,7 +222,7 @@ static void __blk_add_trace(struct blk_t
 	pid_t pid;
 	int cpu, pc = 0;
 	bool blk_tracer = blk_tracer_enabled;
-	ssize_t cgid_len = cgid ? sizeof(*cgid) : 0;
+	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
 
 	if (unlikely(bt->trace_state != Blktrace_running && !blk_tracer))
 		return;
@@ -294,7 +293,7 @@ record_it:
 		t->pdu_len = pdu_len + cgid_len;
 
 		if (cgid_len)
-			memcpy((void *)t + sizeof(*t), cgid, cgid_len);
+			*(u64 *)(t + 1) = cgid;
 		if (pdu_len)
 			memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
 
@@ -751,31 +750,29 @@ void blk_trace_shutdown(struct request_q
 }
 
 #ifdef CONFIG_BLK_CGROUP
-static union kernfs_node_id *
-blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
+static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 {
 	struct blk_trace *bt = q->blk_trace;
 
 	if (!bt || !(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
-		return NULL;
+		return 0;
 
 	if (!bio->bi_blkg)
-		return NULL;
+		return 0;
 	return cgroup_get_kernfs_id(bio_blkcg(bio)->css.cgroup);
 }
 #else
-static union kernfs_node_id *
-blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
+u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 {
-	return NULL;
+	return 0;
 }
 #endif
 
-static union kernfs_node_id *
+static u64
 blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)
 {
 	if (!rq->bio)
-		return NULL;
+		return 0;
 	/* Use the first bio */
 	return blk_trace_bio_get_cgid(q, rq->bio);
 }
@@ -797,8 +794,7 @@ blk_trace_request_get_cgid(struct reques
  *
  **/
 static void blk_add_trace_rq(struct request *rq, int error,
-			     unsigned int nr_bytes, u32 what,
-			     union kernfs_node_id *cgid)
+			     unsigned int nr_bytes, u32 what, u64 cgid)
 {
 	struct blk_trace *bt = rq->q->blk_trace;
 
@@ -913,7 +909,7 @@ static void blk_add_trace_getrq(void *ig
 
 		if (bt)
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
-					NULL, NULL);
+					NULL, 0);
 	}
 }
 
@@ -929,7 +925,7 @@ static void blk_add_trace_sleeprq(void *
 
 		if (bt)
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
-					0, 0, NULL, NULL);
+					0, 0, NULL, 0);
 	}
 }
 
@@ -938,7 +934,7 @@ static void blk_add_trace_plug(void *ign
 	struct blk_trace *bt = q->blk_trace;
 
 	if (bt)
-		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, NULL);
+		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
 }
 
 static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
@@ -955,7 +951,7 @@ static void blk_add_trace_unplug(void *i
 		else
 			what = BLK_TA_UNPLUG_TIMER;
 
-		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, NULL);
+		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0);
 	}
 }
 
@@ -1173,18 +1169,18 @@ const struct blk_io_trace *te_blk_io_tra
 static inline const void *pdu_start(const struct trace_entry *ent, bool has_cg)
 {
 	return (void *)(te_blk_io_trace(ent) + 1) +
-		(has_cg ? sizeof(union kernfs_node_id) : 0);
+		(has_cg ? sizeof(u64) : 0);
 }
 
-static inline const void *cgid_start(const struct trace_entry *ent)
+static inline u64 t_cgid(const struct trace_entry *ent)
 {
-	return (void *)(te_blk_io_trace(ent) + 1);
+	return *(u64 *)(te_blk_io_trace(ent) + 1);
 }
 
 static inline int pdu_real_len(const struct trace_entry *ent, bool has_cg)
 {
 	return te_blk_io_trace(ent)->pdu_len -
-			(has_cg ? sizeof(union kernfs_node_id) : 0);
+			(has_cg ? sizeof(u64) : 0);
 }
 
 static inline u32 t_action(const struct trace_entry *ent)
@@ -1257,7 +1253,7 @@ static void blk_log_action(struct trace_
 
 	fill_rwbs(rwbs, t);
 	if (has_cg) {
-		const union kernfs_node_id *id = cgid_start(iter->ent);
+		u64 id = t_cgid(iter->ent);
 
 		if (blk_tracer_flags.val & TRACE_BLK_OPT_CGNAME) {
 			char blkcg_name_buf[NAME_MAX + 1] = "<...>";
@@ -1269,9 +1265,9 @@ static void blk_log_action(struct trace_
 				 blkcg_name_buf, act, rwbs);
 		} else
 			trace_seq_printf(&iter->seq,
-				 "%3d,%-3d %x,%-x %2s %3s ",
+				 "%3d,%-3d %llx,%-llx %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device),
-				 id->ino, id->generation, act, rwbs);
+				 id & U32_MAX, id >> 32, act, rwbs);
 	} else
 		trace_seq_printf(&iter->seq, "%3d,%-3d %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device), act, rwbs);
Index: work/net/core/filter.c
===================================================================
--- work.orig/net/core/filter.c
+++ work/net/core/filter.c
@@ -4089,7 +4089,7 @@ BPF_CALL_1(bpf_skb_cgroup_id, const stru
 		return 0;
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	return cgrp->kn->id.id;
+	return cgrp->kn->id;
 }
 
 static const struct bpf_func_proto bpf_skb_cgroup_id_proto = {
@@ -4114,7 +4114,7 @@ BPF_CALL_2(bpf_skb_ancestor_cgroup_id, c
 	if (!ancestor)
 		return 0;
 
-	return ancestor->kn->id.id;
+	return ancestor->kn->id;
 }
 
 static const struct bpf_func_proto bpf_skb_ancestor_cgroup_id_proto = {
Index: work/include/linux/exportfs.h
===================================================================
--- work.orig/include/linux/exportfs.h
+++ work/include/linux/exportfs.h
@@ -105,6 +105,11 @@ enum fid_type {
 	FILEID_LUSTRE = 0x97,
 
 	/*
+	 * 64 bit unique kernfs id
+	 */
+	FILEID_KERNFS = 0xfe,
+
+	/*
 	 * Filesystems must not use 0xff file ID.
 	 */
 	FILEID_INVALID = 0xff,
