Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EC5205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxF4mUsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfJARSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:18:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36661 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfJARSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:18:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so16505637wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UNaMEgGAJMbJwBrP83KvS6OAh2pYwA2pbSYvIU1Jggc=;
        b=fxF4mUsXg6KUyZr2IVOuq974dwqP4XgDg9IGaHldIuZRa+d+q1qtYLPcLLMg3GmuXo
         I1s1ZDQ/6rYiLamDGem7XfYMQZvTmKgoB/yL2rsRv8x1UM6JQqhwJ8J6jf7n6RAhiw0X
         GPZ7Y0DeN4HJNGOVL9IcqtG/UF8ZD3TZpJYyjP3F6V/DQXO9ud6PjMuQN7aao97H6Ixo
         6W++YsUM8tep6nerkPPYE7Bgr4Fr+HBZl87ZvmA4hcA5qIr3CF5YFqsb6wMUIdbcKCH9
         PHH4u94pFq7Qd/M16Qr8jDjG8uj/KfikJAvA7kApr6VwW9N8xQ/peo5kvZUKqso+gyET
         YJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UNaMEgGAJMbJwBrP83KvS6OAh2pYwA2pbSYvIU1Jggc=;
        b=MiI7RvpXJzQS8DZKJFqF4fL0smsm50hMiBU6jZD4OadNxcxZ60bN20IsLh3NnKZ0si
         KPaC1QgeC7as/1V5v1SjFtDxOP+AG18tzWf7oFSuIvJ+martyEKl4CEK4CvRoq2uii5Z
         vIGiXaxPO5xmLN/BIv/Q11ziH8SYo+q0wB8Q1pWxgW/CDcIJRUMYo2o2+HSURgAWiGUQ
         n1OGRCMuTr/yUMRPJoQfz2Uga8tWu4e5BpJQ7kmNyWqMijq+QiM7RUY/lvRhy36WjwFd
         koR5gjhf5ZNMI7dUi6LkqDqUTj3iNEsFty9ZZN6WON2sqNAU+zhjVH2szleUCNSofNTL
         tTvQ==
X-Gm-Message-State: APjAAAUpQZZyZI7vVxUYE9hK28S3HXaiPDzyLphoSSydoaF4MoRd5pGb
        GE+PeLYJS+p9DiAJp4znV7I=
X-Google-Smtp-Source: APXvYqykDUBt7cGhKfXsjz8tKZdIfTgtTUG+zgT9tclFj/2nDhUqH4cdDeP8M80UuHCvH35Mj2cVcA==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr8639163wrs.319.1569950294759;
        Tue, 01 Oct 2019 10:18:14 -0700 (PDT)
Received: from darwi-home-pc ([46.183.103.17])
        by smtp.gmail.com with ESMTPSA id r12sm17699541wrq.88.2019.10.01.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 10:18:14 -0700 (PDT)
Date:   Tue, 1 Oct 2019 19:18:05 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, a.darwish@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20191001171805.GA2982@darwi-home-pc>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191001161448.GA1918@darwi-home-pc>
 <201910010932.C6DF862@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201910010932.C6DF862@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:37:39AM -0700, Kees Cook wrote:
> On Tue, Oct 01, 2019 at 06:15:02PM +0200, Ahmed S. Darwish wrote:
> > On Sat, Sep 28, 2019 at 04:53:52PM -0700, Linus Torvalds wrote:
> > > Ahmed - would you be willing to test this on your problem case (with
> > > the ext4 optimization re-enabled, of course)?
> > >
> > 
> > So I pulled the patch and the revert of the ext4 revert as they're all
> > now merged in master. It of course made the problem go away...
> > 
> > To test the quality of the new jitter code, I added a small patch on
> > top to disable all other sources of randomness except the new jitter
> > entropy code, [1] and made quick tests on the quality of getrandom(0).
> > 
> > Using the "ent" tool, [2] also used to test randomness in the Stephen
> > Müller LRNG paper, on a 500000-byte file, produced the following
> > results:
> > 
> >     $ ent rand-file
> > 
> >     Entropy = 7.999625 bits per byte.
> > 
> >     Optimum compression would reduce the size of this 500000 byte file
> >     by 0 percent.
> > 
> >     Chi square distribution for 500000 samples is 259.43, and randomly
> >     would exceed this value 41.11 percent of the times.
> > 
> >     Arithmetic mean value of data bytes is 127.4085 (127.5 = random).
> > 
> >     Monte Carlo value for Pi is 3.148476594 (error 0.22 percent).
> > 
> >     Serial correlation coefficient is 0.001740 (totally uncorrelated = 0.0).
> > 
> > As can be seen above, everything looks random, and almost all of the
> > statistical randomness tests matched the same kernel without the
> > "jitter + schedule()" patch added (after getting it un-stuck).
> 
> Can you post the patch for [1]?
>

Yup, it was the quick&dirty patch below:

(discussion continues after the patch)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c2f7de9dc543..26d0d2bb3337 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1177,6 +1177,8 @@ struct timer_rand_state {
  */
 void add_device_randomness(const void *buf, unsigned int size)
 {
+	return;
+
 	unsigned long time = random_get_entropy() ^ jiffies;
 	unsigned long flags;
 
@@ -1205,6 +1207,8 @@ static struct timer_rand_state input_timer_state = INIT_TIMER_RAND_STATE;
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
+	return;
+
 	struct entropy_store	*r;
 	struct {
 		long jiffies;
@@ -1255,6 +1259,8 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value)
 {
+	return;
+
 	static unsigned char last_value;
 
 	/* ignore autorepeat and the like */
@@ -1308,6 +1314,8 @@ static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 
 void add_interrupt_randomness(int irq, int irq_flags)
 {
+	return;
+
 	struct entropy_store	*r;
 	struct fast_pool	*fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs		*regs = get_irq_regs();
@@ -1375,6 +1383,8 @@ EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 #ifdef CONFIG_BLOCK
 void add_disk_randomness(struct gendisk *disk)
 {
+	return;
+
 	if (!disk || !disk->random)
 		return;
 	/* first major is 1, so we get >= 0x200 here */
@@ -2489,6 +2499,8 @@ randomize_page(unsigned long start, unsigned long range)
 void add_hwgenerator_randomness(const char *buffer, size_t count,
 				size_t entropy)
 {
+	return;
+
 	struct entropy_store *poolp = &input_pool;
 
 	if (unlikely(crng_init == 0)) {
@@ -2515,9 +2527,11 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
  */
 void add_bootloader_randomness(const void *buf, unsigned int size)
 {
+	return;
+
 	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
 		add_hwgenerator_randomness(buf, size, size * 8);
 	else

> Another test we should do is the
> multi-boot test. Testing the stream (with ent, or with my dieharder run)
> is mainly testing the RNG algo. I'd like to see if the first 8 bytes
> out of the kernel RNG change between multiple boots of the same system.
> e.g. read the first 8 bytes, for each of 100000 boots, and feed THAT
> byte "stream" into ent...
>

Oh, indeed, that's an excellent point... I'll prototype this and come
back.

thanks,

--
Ahmed Darwish
