Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A36218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLRKbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:31:08 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56149 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfLRKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 05:31:08 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBIATpNC011264;
        Wed, 18 Dec 2019 19:29:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Wed, 18 Dec 2019 19:29:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBIATkm1011020
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 18 Dec 2019 19:29:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com>
 <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu>
 <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cca315b2-d2c0-0bcb-35d9-f830b028fb4d@i-love.sakura.ne.jp>
Date:   Wed, 18 Dec 2019 19:29:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/17 17:36, Dmitry Vyukov wrote:
> FWIW we've just disabled sysrq entirely:
> https://github.com/google/syzkaller/blob/master/dashboard/config/bits-syzbot.config#L182
> because random packets over usb can trigger a panic sysrq (again
> almost impossible to reliably filter these out on fuzzer side).

Excuse me, but CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x0 helps only if show_state() etc. are
called via the __handle_sysrq() handler in drivers/tty/sysrq.c .

  static void sysrq_handle_showstate(int key)
  {
  	show_state();
  	show_workqueue_state();
  }
  static struct sysrq_key_op sysrq_showstate_op = {
  	.handler	= sysrq_handle_showstate,
  	.help_msg	= "show-task-states(t)",
  	.action_msg	= "Show State",
  	.enable_mask	= SYSRQ_ENABLE_DUMP,
  };

The k_spec() handler in drivers/tty/vt/keyboard.c calls show_state() etc. without
evaluating sysrq_enabled value.

  #define FN_HANDLERS\
  	fn_null,	fn_enter,	fn_show_ptregs,	fn_show_mem,\
  	fn_show_state,	fn_send_intr,	fn_lastcons,	fn_caps_toggle,\
  	fn_num,		fn_hold,	fn_scroll_forw,	fn_scroll_back,\
  	fn_boot_it,	fn_caps_on,	fn_compose,	fn_SAK,\
  	fn_dec_console, fn_inc_console, fn_spawn_con,	fn_bare_num
  
  typedef void (fn_handler_fn)(struct vc_data *vc);
  static fn_handler_fn FN_HANDLERS;
  static fn_handler_fn *fn_handler[] = { FN_HANDLERS };

  static void fn_show_state(struct vc_data *vc)
  {
  	show_state();
  }

  static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
  {
  	if (up_flag)
  		return;
  	if (value >= ARRAY_SIZE(fn_handler))
  		return;
  	if ((kbd->kbdmode == VC_RAW ||
  	     kbd->kbdmode == VC_MEDIUMRAW ||
  	     kbd->kbdmode == VC_OFF) &&
  	     value != KVAL(K_SAK))
  		return;		/* SAK is allowed even in raw mode */
  	fn_handler[value](vc);
  }

Therefore, we need to guard at either callee side (e.g. show_state_filter())
or caller side (e.g. k_spec()) using kernel config (or something equivalent)
in order to avoid forever calling show_state() from timer function.
