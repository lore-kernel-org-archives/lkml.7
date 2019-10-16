Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4449C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB51E20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbfJPJdA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:33:00 -0400
Received: from foss.arm.com ([217.140.110.172]:33820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfJPJdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:33:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C777142F;
        Wed, 16 Oct 2019 02:32:59 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178203F6C4;
        Wed, 16 Oct 2019 02:32:57 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:32:48 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julien Grall <julien.grall@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, tglx@linutronix.de
Subject: Re: [PATCH REPOST] lib/ubsan: Don't seralize UBSAN report
Message-ID: <20191016103248.3d5f1d4f@donnerap.cambridge.arm.com>
In-Reply-To: <20191010163616.qon4ppmhf74l4fix@linutronix.de>
References: <20191010163616.qon4ppmhf74l4fix@linutronix.de>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 18:36:16 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

Hi,

you seem to be me missing the "From:" line here, to keep Julien as the author. If you have this patch in a git repo, you could use:
$ git commit --amend --author "Julien Grall <julien.grall@arm.com>"
so that git keeps the authorship, which should be translated into the proper email form (From: ...) by git send-email.

And what is the reason for the repost anyway?

Cheers,
Andre.

> At the moment, UBSAN report will be serialized using a spin_lock(). On
> RT-systems, spinlocks are turned to rt_spin_lock and may sleep. This will
> result to the following splat if the undefined behavior is in a context
> that can not sleep:
> 
> | BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
> | in_atomic(): 1, irqs_disabled(): 128, pid: 3447, name: make
> | 1 lock held by make/3447:
> |  #0: 000000009a966332 (&mm->mmap_sem){++++}, at: do_page_fault+0x140/0x4f8
> | Preemption disabled at:
> | [<ffff000011324a4c>] rt_mutex_futex_unlock+0x4c/0xb0
> | CPU: 3 PID: 3447 Comm: make Tainted: G        W         5.2.14-rt7-01890-ge6e057589653 #911
> | Call trace:
> …
> |  ___might_sleep+0x154/0x210
> |  rt_spin_lock+0x68/0xa0
> |  ubsan_prologue+0x30/0x68
> |  handle_overflow+0x64/0xe0
> |  __ubsan_handle_add_overflow+0x10/0x18
> 
> The spin_lock() will protect against multiple CPUs to output a report
> together, I guess to prevent them to be interleaved. However, they can
> still interleave with other messages (and even splat from __migth_sleep).
> 
> So the lock usefulness seems pretty limited. Rather than trying to
> accomodate RT-system by switching to a raw_spin_lock(), the lock is now
> completely dropped.
> 
> Link: https://lkml.kernel.org/r/20190920100835.14999-1-julien.grall@arm.com
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: 
> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Repost of
>   https://lkml.kernel.org/r/20190920100835.14999-1-julien.grall@arm.com
> 
>  lib/ubsan.c | 64 +++++++++++++++++++----------------------------------
>  1 file changed, 23 insertions(+), 41 deletions(-)
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index e7d31735950de..39d5952c42733 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -140,25 +140,21 @@ static void val_to_string(char *str, size_t size, struct type_descriptor *type,
>  	}
>  }
>  
> -static DEFINE_SPINLOCK(report_lock);
> -
> -static void ubsan_prologue(struct source_location *location,
> -			unsigned long *flags)
> +static void ubsan_prologue(struct source_location *location)
>  {
>  	current->in_ubsan++;
> -	spin_lock_irqsave(&report_lock, *flags);
>  
>  	pr_err("========================================"
>  		"========================================\n");
>  	print_source_location("UBSAN: Undefined behaviour in", location);
>  }
>  
> -static void ubsan_epilogue(unsigned long *flags)
> +static void ubsan_epilogue(void)
>  {
>  	dump_stack();
>  	pr_err("========================================"
>  		"========================================\n");
> -	spin_unlock_irqrestore(&report_lock, *flags);
> +
>  	current->in_ubsan--;
>  }
>  
> @@ -167,14 +163,13 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
>  {
>  
>  	struct type_descriptor *type = data->type;
> -	unsigned long flags;
>  	char lhs_val_str[VALUE_LENGTH];
>  	char rhs_val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(lhs_val_str, sizeof(lhs_val_str), type, lhs);
>  	val_to_string(rhs_val_str, sizeof(rhs_val_str), type, rhs);
> @@ -186,7 +181,7 @@ static void handle_overflow(struct overflow_data *data, void *lhs,
>  		rhs_val_str,
>  		type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  
>  void __ubsan_handle_add_overflow(struct overflow_data *data,
> @@ -214,20 +209,19 @@ EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
>  void __ubsan_handle_negate_overflow(struct overflow_data *data,
>  				void *old_val)
>  {
> -	unsigned long flags;
>  	char old_val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
>  
>  	pr_err("negation of %s cannot be represented in type %s:\n",
>  		old_val_str, data->type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
>  
> @@ -235,13 +229,12 @@ EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
>  void __ubsan_handle_divrem_overflow(struct overflow_data *data,
>  				void *lhs, void *rhs)
>  {
> -	unsigned long flags;
>  	char rhs_val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(rhs_val_str, sizeof(rhs_val_str), data->type, rhs);
>  
> @@ -251,58 +244,52 @@ void __ubsan_handle_divrem_overflow(struct overflow_data *data,
>  	else
>  		pr_err("division by zero\n");
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_divrem_overflow);
>  
>  static void handle_null_ptr_deref(struct type_mismatch_data_common *data)
>  {
> -	unsigned long flags;
> -
>  	if (suppress_report(data->location))
>  		return;
>  
> -	ubsan_prologue(data->location, &flags);
> +	ubsan_prologue(data->location);
>  
>  	pr_err("%s null pointer of type %s\n",
>  		type_check_kinds[data->type_check_kind],
>  		data->type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  
>  static void handle_misaligned_access(struct type_mismatch_data_common *data,
>  				unsigned long ptr)
>  {
> -	unsigned long flags;
> -
>  	if (suppress_report(data->location))
>  		return;
>  
> -	ubsan_prologue(data->location, &flags);
> +	ubsan_prologue(data->location);
>  
>  	pr_err("%s misaligned address %p for type %s\n",
>  		type_check_kinds[data->type_check_kind],
>  		(void *)ptr, data->type->type_name);
>  	pr_err("which requires %ld byte alignment\n", data->alignment);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  
>  static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
>  					unsigned long ptr)
>  {
> -	unsigned long flags;
> -
>  	if (suppress_report(data->location))
>  		return;
>  
> -	ubsan_prologue(data->location, &flags);
> +	ubsan_prologue(data->location);
>  	pr_err("%s address %p with insufficient space\n",
>  		type_check_kinds[data->type_check_kind],
>  		(void *) ptr);
>  	pr_err("for an object of type %s\n", data->type->type_name);
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  
>  static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
> @@ -351,25 +338,23 @@ EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
>  
>  void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
>  {
> -	unsigned long flags;
>  	char index_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(index_str, sizeof(index_str), data->index_type, index);
>  	pr_err("index %s is out of range for type %s\n", index_str,
>  		data->array_type->type_name);
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_out_of_bounds);
>  
>  void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>  					void *lhs, void *rhs)
>  {
> -	unsigned long flags;
>  	struct type_descriptor *rhs_type = data->rhs_type;
>  	struct type_descriptor *lhs_type = data->lhs_type;
>  	char rhs_str[VALUE_LENGTH];
> @@ -378,7 +363,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(rhs_str, sizeof(rhs_str), rhs_type, rhs);
>  	val_to_string(lhs_str, sizeof(lhs_str), lhs_type, lhs);
> @@ -401,18 +386,16 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
>  			lhs_str, rhs_str,
>  			lhs_type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
>  
>  
>  void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
>  {
> -	unsigned long flags;
> -
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  	pr_err("calling __builtin_unreachable()\n");
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  	panic("can't return from __builtin_unreachable()");
>  }
>  EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
> @@ -420,19 +403,18 @@ EXPORT_SYMBOL(__ubsan_handle_builtin_unreachable);
>  void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
>  				void *val)
>  {
> -	unsigned long flags;
>  	char val_str[VALUE_LENGTH];
>  
>  	if (suppress_report(&data->location))
>  		return;
>  
> -	ubsan_prologue(&data->location, &flags);
> +	ubsan_prologue(&data->location);
>  
>  	val_to_string(val_str, sizeof(val_str), data->type, val);
>  
>  	pr_err("load of value %s is not a valid value for type %s\n",
>  		val_str, data->type->type_name);
>  
> -	ubsan_epilogue(&flags);
> +	ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);

