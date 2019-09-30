Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEAFC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F214D21721
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfI3J01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfI3J00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:26:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CCE63083363;
        Mon, 30 Sep 2019 09:26:26 +0000 (UTC)
Received: from krava (unknown [10.40.205.53])
        by smtp.corp.redhat.com (Postfix) with SMTP id D52DF5D70D;
        Mon, 30 Sep 2019 09:26:21 +0000 (UTC)
Date:   Mon, 30 Sep 2019 11:26:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, adrian.hunter@intel.com,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        huawei.libin@huawei.com
Subject: Re: [PATCH] perf symbols: Don't split kernel symbols when using
 kallsyms
Message-ID: <20190930092620.GD602@krava>
References: <20190929123425.22589-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929123425.22589-1-liwei391@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 30 Sep 2019 09:26:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 08:34:25PM +0800, Wei Li wrote:
> If there is ovelapping of vmlinux addresses with modules on a system,
> the kernel symbols will be split to unique DSOs([kernel].N) when using
> /proc/kallsyms, introduced by commit 2e538c4a1847 ("perf tools: Improve
> kernel/modules symbol lookup").
> 
> When doing perf probe/report on such a system, it will fail in finding
> symbol, as the symbol split process is after the map searching, and the
> created maps can't be matched with name in kernel_get_module_map().

hi,
could you please write the whole failing code path/stack?

> 
> I think the split is confusing and not so useful when using [kernel].N
> instead of the original ELF section names here. So remove the split
> process when using /proc/kallsyms only.

I haven't seens this code for some time, so I might be missing
something, but we currently create new maps/dso for the overlapping
parts like:

   [kernel]
   [mod1]
   [kernel].1
   [mod2]
   [kernel].2
   [mod3]
   [kernel].3

IIUC your change wont create new map/dso pairs and will dend up with:

   [kernel]
   [mod1]
   [mod2]
   [mod3]

and map_groups__fixup_end call will fix [kernel].end to [mod1].start

then what happens when you want to resolve symbol from [kernel].3 range ?

thanks,
jirka


> 
> On my arm32 system:
> 
> V2R7C00_HI1212-OSN9800 ~/liwei # ./perf probe -v -a printk
> probe-definition(0): printk
> symbol:printk file:(null) line:0 offset:0 return:0 lazy:(null)
> 0 arguments
> map_groups__set_modules_path_dir: cannot open /lib/modules/5.3.0-rc5+ dir
> Problems setting modules path maps, continuing anyway...
> No kprobe blacklist support, ignored
> Failed to open cache(-1): /root/.debug/[kernel.kallsyms]/8eb36727183e955c790f0c7feb22d8306be7ce99/probes
> Cache open error: -1
> Looking at the vmlinux_path (8 entries long)
> symsrc__init: cannot get elf header.
> Could not open debuginfo. Try to use symbols.
> Looking at the vmlinux_path (8 entries long)
> symsrc__init: cannot get elf header.
> Failed to open /proc/kcore. Note /proc/kcore requires CAP_SYS_RAWIO capability to access.
> Using /proc/kallsyms for symbols
> Failed to find symbol printk in kernel
>   Error: Failed to add events. Reason: No such file or directory (Code: -2)
> 
> V2R7C00_HI1212-OSN9800 ~/liwei # ./perf probe -F
> vector_addrexcptn
> vector_dabt
> vector_fiq
> vector_irq
> vector_pabt
> vector_rst
> vector_und
> 
> V2R7C00_HI1212-OSN9800 ~/liwei # sort -u /proc/kallsyms | head -n 10
> 01df0000 t __vectors_start
> 01df1000 t __stubs_start
> 01df1004 t vector_rst
> 01df1020 t vector_irq
> 01df10a0 t vector_dabt
> 01df1120 t vector_pabt
> 01df11a0 t vector_und
> 01df1220 t vector_addrexcptn
> 01df1240 T vector_fiq
> bf000000 t $a	[eth]
> 
> V2R7C00_HI1212-OSN9800 ~/liwei # sort -u /proc/kallsyms | grep _stext -B 10
> c1e04000 t swapper_pg_dir
> c1e08000 T stext
> c1e08000 t _text
> c1e080b8 t __create_page_tables
> c1e081bc t __fixup_smp
> c1e08224 t __fixup_smp_on_up
> c1e08240 t __fixup_pv_table
> c1e082b0 t __vet_atags
> c1e08300 T __turn_mmu_on
> c1e08300 t __idmap_text_start
> c1e08300 t _stext
> 
> V2R7C00_HI1212-OSN9800 ~/liwei # ./perf record -a sleep 2
> Couldn't synthesize bpf events.
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.024 MB perf.data (140 samples) ]
> V2R7C00_HI1212-OSN9800 ~/liwei # ./perf report
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 140  of event 'cycles'
> # Event count (approx.): 9286809
> #
> # Overhead  Command  Shared Object      Symbol
> # ........  .......  .................  .................
> #
>     15.89%  swapper  [unknown]          [k] 0xc1e10b2c
>      7.83%  swapper  [unknown]          [k] 0xc1e303f4
>      6.66%  swapper  [unknown]          [k] 0xc1e84d58
>      6.28%  sleep    ld-2.27.so         [.] do_lookup_x
>      6.07%  swapper  [unknown]          [k] 0xc23f59dc
>      3.19%  swapper  [unknown]          [k] 0xc23f0bfc
>      3.18%  swapper  [unknown]          [k] 0xc2194d18
>      3.18%  sleep    libc-2.27.so       [.] _dl_addr
>      3.17%  sleep    [unknown]          [k] 0xc1e23454
>      3.16%  sleep    ld-2.27.so         [.] check_match
>      3.12%  sleep    ld-2.27.so         [.] strcmp
>      3.12%  swapper  [unknown]          [k] 0xc1e52ce8
>      3.10%  sleep    [unknown]          [k] 0xc1f738a4
>      3.08%  sleep    [unknown]          [k] 0xc21a1ef8
>      3.05%  sleep    [unknown]          [k] 0xc1f7109c
>      3.02%  sleep    [unknown]          [k] 0xc1f59520
>      2.99%  sleep    [unknown]          [k] 0xc23f54d4
> 	 ...
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/util/symbol.c | 54 ++++++----------------------------------
>  1 file changed, 7 insertions(+), 47 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4efde7879474..1c0d6d0e4ed1 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -743,9 +743,7 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
>  }
>  
>  /*
> - * Split the symbols into maps, making sure there are no overlaps, i.e. the
> - * kernel range is broken in several maps, named [kernel].N, as we don't have
> - * the original ELF section names vmlinux have.
> + * Remove module and useless symbols from the map derived from /proc/kallsyms.
>   */
>  static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso, u64 delta,
>  				      struct map *initial_map)
> @@ -753,10 +751,9 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
>  	struct machine *machine;
>  	struct map *curr_map = initial_map;
>  	struct symbol *pos;
> -	int count = 0, moved = 0;
> +	int moved = 0;
>  	struct rb_root_cached *root = &dso->symbols;
>  	struct rb_node *next = rb_first_cached(root);
> -	int kernel_range = 0;
>  	bool x86_64;
>  
>  	if (!kmaps)
> @@ -823,57 +820,20 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
>  			 * symbols at this point.
>  			 */
>  			goto discard_symbol;
> -		} else if (curr_map != initial_map) {
> -			char dso_name[PATH_MAX];
> -			struct dso *ndso;
> -
> +		} else {
> +			curr_map = initial_map;
>  			if (delta) {
>  				/* Kernel was relocated at boot time */
>  				pos->start -= delta;
>  				pos->end -= delta;
>  			}
> -
> -			if (count == 0) {
> -				curr_map = initial_map;
> -				goto add_symbol;
> -			}
> -
> -			if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
> -				snprintf(dso_name, sizeof(dso_name),
> -					"[guest.kernel].%d",
> -					kernel_range++);
> -			else
> -				snprintf(dso_name, sizeof(dso_name),
> -					"[kernel].%d",
> -					kernel_range++);
> -
> -			ndso = dso__new(dso_name);
> -			if (ndso == NULL)
> -				return -1;
> -
> -			ndso->kernel = dso->kernel;
> -
> -			curr_map = map__new2(pos->start, ndso);
> -			if (curr_map == NULL) {
> -				dso__put(ndso);
> -				return -1;
> -			}
> -
> -			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
> -			map_groups__insert(kmaps, curr_map);
> -			++kernel_range;
> -		} else if (delta) {
> -			/* Kernel was relocated at boot time */
> -			pos->start -= delta;
> -			pos->end -= delta;
>  		}
> -add_symbol:
> +
>  		if (curr_map != initial_map) {
>  			rb_erase_cached(&pos->rb_node, root);
>  			symbols__insert(&curr_map->dso->symbols, pos);
>  			++moved;
> -		} else
> -			++count;
> +		}
>  
>  		continue;
>  discard_symbol:
> @@ -887,7 +847,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
>  		dso__set_loaded(curr_map->dso);
>  	}
>  
> -	return count + moved;
> +	return moved;
>  }
>  
>  bool symbol__restricted_filename(const char *filename,
> -- 
> 2.17.1
> 
