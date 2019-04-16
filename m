Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B49C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4264A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfDPKPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:15:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:6730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfDPKPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:15:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 03:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="gz'50?scan'50,208,50";a="162016538"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2019 03:15:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hGL7w-000AyB-Dl; Tue, 16 Apr 2019 18:15:44 +0800
Date:   Tue, 16 Apr 2019 18:14:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: [tip:WIP.core/stacktrace 4/32] kernel/stacktrace.c:99:1: error:
 redefinition of 'save_stack_trace_tsk_reliable'
Message-ID: <201904161843.J7aJJ9wG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/stacktrace
head:   9fe290aca53f59fd24187841dd4a8ff41ade91bd
commit: 714f46ba649b163e80d3dd89e83b92f4ba5ac6af [4/32] stacktrace: Provide helpers for common stack trace operations
config: sparc64-defconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 714f46ba649b163e80d3dd89e83b92f4ba5ac6af
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   In file included from include/linux/page_ext.h:6:0,
                    from include/linux/mm.h:24,
                    from include/linux/kallsyms.h:12,
                    from kernel/stacktrace.c:11:
   include/linux/stacktrace.h:62:19: error: static declaration of 'save_stack_trace_tsk_reliable' follows non-static declaration
    static inline int save_stack_trace_tsk_reliable(struct task_struct *tsk,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stacktrace.h:39:12: note: previous declaration of 'save_stack_trace_tsk_reliable' was here
    extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/stacktrace.c:99:1: error: redefinition of 'save_stack_trace_tsk_reliable'
    save_stack_trace_tsk_reliable(struct task_struct *tsk,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/page_ext.h:6:0,
                    from include/linux/mm.h:24,
                    from include/linux/kallsyms.h:12,
                    from kernel/stacktrace.c:11:
   include/linux/stacktrace.h:62:19: note: previous definition of 'save_stack_trace_tsk_reliable' was here
    static inline int save_stack_trace_tsk_reliable(struct task_struct *tsk,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/save_stack_trace_tsk_reliable +99 kernel/stacktrace.c

8637c0990 Ingo Molnar      2006-07-03  @11  #include <linux/kallsyms.h>
8637c0990 Ingo Molnar      2006-07-03   12  #include <linux/stacktrace.h>
8637c0990 Ingo Molnar      2006-07-03   13  
714f46ba6 Thomas Gleixner  2019-04-09   14  /**
714f46ba6 Thomas Gleixner  2019-04-09   15   * stack_trace_print - Print the entries in the stack trace
714f46ba6 Thomas Gleixner  2019-04-09   16   * @entries:	Pointer to storage array
714f46ba6 Thomas Gleixner  2019-04-09   17   * @nr_entries:	Number of entries in the storage array
714f46ba6 Thomas Gleixner  2019-04-09   18   * @spaces:	Number of leading spaces to print
714f46ba6 Thomas Gleixner  2019-04-09   19   */
714f46ba6 Thomas Gleixner  2019-04-09   20  void stack_trace_print(unsigned long *entries, unsigned int nr_entries,
714f46ba6 Thomas Gleixner  2019-04-09   21  		       int spaces)
8637c0990 Ingo Molnar      2006-07-03   22  {
714f46ba6 Thomas Gleixner  2019-04-09   23  	unsigned int i;
8637c0990 Ingo Molnar      2006-07-03   24  
714f46ba6 Thomas Gleixner  2019-04-09   25  	if (WARN_ON(!entries))
bfeeeeb99 Johannes Berg    2008-05-12   26  		return;
bfeeeeb99 Johannes Berg    2008-05-12   27  
714f46ba6 Thomas Gleixner  2019-04-09   28  	for (i = 0; i < nr_entries; i++)
714f46ba6 Thomas Gleixner  2019-04-09   29  		printk("%*c%pS\n", 1 + spaces, ' ', (void *)entries[i]);
714f46ba6 Thomas Gleixner  2019-04-09   30  }
714f46ba6 Thomas Gleixner  2019-04-09   31  EXPORT_SYMBOL_GPL(stack_trace_print);
714f46ba6 Thomas Gleixner  2019-04-09   32  
714f46ba6 Thomas Gleixner  2019-04-09   33  void print_stack_trace(struct stack_trace *trace, int spaces)
714f46ba6 Thomas Gleixner  2019-04-09   34  {
714f46ba6 Thomas Gleixner  2019-04-09   35  	stack_trace_print(trace->entries, trace->nr_entries, spaces);
8637c0990 Ingo Molnar      2006-07-03   36  }
8594698eb Ingo Molnar      2008-06-27   37  EXPORT_SYMBOL_GPL(print_stack_trace);
8637c0990 Ingo Molnar      2006-07-03   38  
714f46ba6 Thomas Gleixner  2019-04-09   39  /**
714f46ba6 Thomas Gleixner  2019-04-09   40   * stack_trace_snprint - Print the entries in the stack trace into a buffer
714f46ba6 Thomas Gleixner  2019-04-09   41   * @buf:	Pointer to the print buffer
714f46ba6 Thomas Gleixner  2019-04-09   42   * @size:	Size of the print buffer
714f46ba6 Thomas Gleixner  2019-04-09   43   * @entries:	Pointer to storage array
714f46ba6 Thomas Gleixner  2019-04-09   44   * @nr_entries:	Number of entries in the storage array
714f46ba6 Thomas Gleixner  2019-04-09   45   * @spaces:	Number of leading spaces to print
714f46ba6 Thomas Gleixner  2019-04-09   46   */
714f46ba6 Thomas Gleixner  2019-04-09   47  int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
714f46ba6 Thomas Gleixner  2019-04-09   48  			unsigned int nr_entries, int spaces)
9a92a6ce6 Joonsoo Kim      2014-12-12   49  {
714f46ba6 Thomas Gleixner  2019-04-09   50  	unsigned int generated, i, total = 0;
9a92a6ce6 Joonsoo Kim      2014-12-12   51  
714f46ba6 Thomas Gleixner  2019-04-09   52  	if (WARN_ON(!entries))
9a92a6ce6 Joonsoo Kim      2014-12-12   53  		return 0;
9a92a6ce6 Joonsoo Kim      2014-12-12   54  
714f46ba6 Thomas Gleixner  2019-04-09   55  	for (i = 0; i < nr_entries; i++) {
bfeda41d0 Omar Sandoval    2017-02-07   56  		generated = snprintf(buf, size, "%*c%pS\n", 1 + spaces, ' ',
714f46ba6 Thomas Gleixner  2019-04-09   57  				     (void *)entries[i]);
9a92a6ce6 Joonsoo Kim      2014-12-12   58  
9a92a6ce6 Joonsoo Kim      2014-12-12   59  		total += generated;
9a92a6ce6 Joonsoo Kim      2014-12-12   60  		if (generated >= size) {
9a92a6ce6 Joonsoo Kim      2014-12-12   61  			buf += size;
9a92a6ce6 Joonsoo Kim      2014-12-12   62  			size = 0;
9a92a6ce6 Joonsoo Kim      2014-12-12   63  		} else {
9a92a6ce6 Joonsoo Kim      2014-12-12   64  			buf += generated;
9a92a6ce6 Joonsoo Kim      2014-12-12   65  			size -= generated;
9a92a6ce6 Joonsoo Kim      2014-12-12   66  		}
9a92a6ce6 Joonsoo Kim      2014-12-12   67  	}
9a92a6ce6 Joonsoo Kim      2014-12-12   68  
9a92a6ce6 Joonsoo Kim      2014-12-12   69  	return total;
9a92a6ce6 Joonsoo Kim      2014-12-12   70  }
714f46ba6 Thomas Gleixner  2019-04-09   71  EXPORT_SYMBOL_GPL(stack_trace_snprint);
714f46ba6 Thomas Gleixner  2019-04-09   72  
714f46ba6 Thomas Gleixner  2019-04-09   73  int snprint_stack_trace(char *buf, size_t size,
714f46ba6 Thomas Gleixner  2019-04-09   74  			struct stack_trace *trace, int spaces)
714f46ba6 Thomas Gleixner  2019-04-09   75  {
714f46ba6 Thomas Gleixner  2019-04-09   76  	return stack_trace_snprint(buf, size, trace->entries,
714f46ba6 Thomas Gleixner  2019-04-09   77  				   trace->nr_entries, spaces);
714f46ba6 Thomas Gleixner  2019-04-09   78  }
9a92a6ce6 Joonsoo Kim      2014-12-12   79  EXPORT_SYMBOL_GPL(snprint_stack_trace);
9a92a6ce6 Joonsoo Kim      2014-12-12   80  
9212ddb5e Ingo Molnar      2008-12-25   81  /*
af085d908 Josh Poimboeuf   2017-02-13   82   * Architectures that do not implement save_stack_trace_*()
af085d908 Josh Poimboeuf   2017-02-13   83   * get these weak aliases and once-per-bootup warnings
c624d33f6 Masami Hiramatsu 2011-06-08   84   * (whenever this facility is utilized - for example by procfs):
9212ddb5e Ingo Molnar      2008-12-25   85   */
9212ddb5e Ingo Molnar      2008-12-25   86  __weak void
9212ddb5e Ingo Molnar      2008-12-25   87  save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
9212ddb5e Ingo Molnar      2008-12-25   88  {
9212ddb5e Ingo Molnar      2008-12-25   89  	WARN_ONCE(1, KERN_INFO "save_stack_trace_tsk() not implemented yet.\n");
9212ddb5e Ingo Molnar      2008-12-25   90  }
c624d33f6 Masami Hiramatsu 2011-06-08   91  
c624d33f6 Masami Hiramatsu 2011-06-08   92  __weak void
c624d33f6 Masami Hiramatsu 2011-06-08   93  save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
c624d33f6 Masami Hiramatsu 2011-06-08   94  {
c624d33f6 Masami Hiramatsu 2011-06-08   95  	WARN_ONCE(1, KERN_INFO "save_stack_trace_regs() not implemented yet.\n");
c624d33f6 Masami Hiramatsu 2011-06-08   96  }
af085d908 Josh Poimboeuf   2017-02-13   97  
af085d908 Josh Poimboeuf   2017-02-13   98  __weak int
af085d908 Josh Poimboeuf   2017-02-13  @99  save_stack_trace_tsk_reliable(struct task_struct *tsk,
af085d908 Josh Poimboeuf   2017-02-13  100  			      struct stack_trace *trace)
af085d908 Josh Poimboeuf   2017-02-13  101  {
af085d908 Josh Poimboeuf   2017-02-13  102  	WARN_ONCE(1, KERN_INFO "save_stack_tsk_reliable() not implemented yet.\n");
af085d908 Josh Poimboeuf   2017-02-13  103  	return -ENOSYS;
af085d908 Josh Poimboeuf   2017-02-13  104  }
714f46ba6 Thomas Gleixner  2019-04-09  105  

:::::: The code at line 99 was first introduced by commit
:::::: af085d9084b48530153f51e6cad19fd0b1a13ed7 stacktrace/x86: add function for detecting reliable stack traces

:::::: TO: Josh Poimboeuf <jpoimboe@redhat.com>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--T4sUOijqQbZv57TR
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--T4sUOijqQbZv57TR--
