Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF53C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A11520661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JBK87Qvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCHTDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:03:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36712 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfCHTC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:02:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28Ix3Ce044132;
        Fri, 8 Mar 2019 19:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=T9IYAXaaJTbnV9N65KuJDAWHaazB78IOANP+7g8ys4M=;
 b=JBK87QvjmOYHDOUWYFy4RSwv8Wef2SfQ9kSm0nM+YANi8fCFdDQnfwogAmGohn6IqDmu
 3V1rr8tbtgd0BD+STxYfUAu4GUIULVzsgAKh8epnoYM90Wjpm/5gSHksFrZ3roFv5FPV
 l4xup5+KX/C3P58xdqZwDAUhVfaP7hhAkcUqF7H0gjRPdSYjVAwD+t6Cm0BRp/u0DcWY
 pUJDZMY8FLKoOrrUxvQO2Ex1yHtjTj4JtjEp5ltLQ6S8HS/M6BagTPwuE8U9lOvCtKOW
 DGowf1PGeZOThuuav4qxelaSPYiaUUC3Dv5eZC0nbdcpXfUOEqE7rwrpAZ72nZuwF1OX Qg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qyh8ut09n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 19:02:50 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x28J2nTv026153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 19:02:49 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x28J2mFC008975;
        Fri, 8 Mar 2019 19:02:48 GMT
Received: from [10.132.93.82] (/10.132.93.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 11:02:47 -0800
Subject: Re: [PATCH v6] pidns: introduce syscall translate_pid
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <152788068212.768348.15192457501079586650.stgit@buzz>
 <db8d560e-47d1-c32f-e4a2-407110f2b5b6@oracle.com>
 <20181109034919.GA21681@altlinux.org>
From:   Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <37b17950-b130-7933-99a1-4846c61c8555@oracle.com>
Date:   Fri, 8 Mar 2019 10:55:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181109034919.GA21681@altlinux.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9189 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/18 7:49 PM, Dmitry V. Levin wrote:
> Hi,
>
> On Mon, Jul 16, 2018 at 10:57:48AM -0700, Nagarathnam Muthusamy wrote:
>> On 06/01/2018 12:18 PM, Konstantin Khlebnikov wrote:
>>> Each process have different pids, one for each pid namespace it belongs.
>>> When interaction happens within single pid-ns translation isn't required.
>>> More complicated scenarios needs special handling.
>>>
>>> For example:
>>> - reading pid-files or logs written inside container with pid namespace
>>> - writing logs with internal pids outside container for pushing them into
>>> - attaching with ptrace to tasks from different pid namespace
>>>
>>> Generally speaking, any cross pid-ns API with pids needs translation.
>>>
>>> Currently there are several interfaces that could be used here:
>>>
>>> Pid namespaces are identified by device and inode of /proc/[pid]/ns/pid.
>>>
>>> Pids for nested pid namespaces are shown in file /proc/[pid]/status.
>>> In some cases pid translation could be easily done using this information.
>>> Backward translation requires scanning all tasks and becomes really
>>> complicated for deeper namespace nesting.
>>>
>>> Unix socket automatically translates pid attached to SCM_CREDENTIALS.
>>> This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
>>> into pid namespace, this expose process and could be insecure.
>>>
>>> This patch adds new syscall for converting pids between pid namespaces:
>>>
>>> pid_t translate_pid(pid_t pid, int source, int target);
>>>
>>> Pid-namespaces are referred file descriptors opened to proc files
>>> /proc/[pid]/ns/pid or /proc/[pid]/ns/pid_for_children.
>>> Negative argument points to current pid namespace.
>>>
>>> Syscall returns pid in target pid-ns or zero if task have no pid there.
>>>
>>> Error codes:
>>> EBADF    - file descriptor is closed
>>> EINVAL   - file descriptor isn't pid namespace
>>> ESRCH    - task not found in @source namespace
>>>
>>> Translation could breach pid-ns isolation and return pids from outer pid
>>> namespaces iff process already has file descriptor for these namespaces.
>>>
>>> Examples:
>>> translate_pid(pid, ns, -1)      - get pid in our pid namespace
>>> translate_pid(pid, -1, ns)      - get pid in other pid namespace
>>> translate_pid(1, ns, -1)        - get pid of init task for namespace
>>> translate_pid(pid, -1, ns) > 0  - is pid is reachable from ns?
>>> translate_pid(1, ns1, ns2) > 0  - is ns1 inside ns2?
>>> translate_pid(1, ns1, ns2) == 0 - is ns1 outside ns2?
>>> translate_pid(1, ns1, ns2) == 1 - is ns1 equal ns2?
>>>
>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> Reanimated-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
>>>
>>> ---
>>>
>>> v1: https://lkml.org/lkml/2015/9/15/411
>>> v2: https://lkml.org/lkml/2015/9/24/278
>>>    * use namespace-fd as second/third argument
>>>    * add -pid for getting parent pid
>>>    * move code into kernel/sys.c next to getppid
>>>    * drop ifdef CONFIG_PID_NS
>>>    * add generic syscall
>>> v3: https://lkml.org/lkml/2015/9/28/3
>>>    * use proc_ns_fdget()
>>>    * update description
>>>    * rebase to next-20150925
>>>    * fix conflict with mlock2
>>> v4: https://lkml.org/lkml/2017/10/13/177
>>>    * rename from getvpid() into translate_pid()
>>>    * remove syscall if CONFIG_PID_NS=n
>>>    * drop -pid for parent task
>>>    * drop fget-fdget optimizations
>>>    * add helper get_pid_ns_by_fd()
>>>    * wire only into x86
>>> v5: https://lkml.org/lkml/2018/4/4/677
>>>    * rewrite commit message
>>>    * resolve pidns by task pid or by pidns fd
>>>    * add arguments source_type and target_type
>>> v6:
>>>    * revert back minimized v4 design
>>>    * rebase to next-20180601
>>>    * fix COND_SYSCALL stub
>>>    * use next syscall number, old used for io_pgetevents
>>>
>>> --- sample tool ---
>>>
>>> #define _GNU_SOURCE
>>> #include <sys/syscall.h>
>>> #include <sys/types.h>
>>> #include <fcntl.h>
>>> #include <unistd.h>
>>> #include <stdlib.h>
>>> #include <stdio.h>
>>> #include <err.h>
>>>
>>> #ifndef SYS_translate_pid
>>> #ifdef __x86_64__
>>> #define SYS_translate_pid 334
>>> #elif defined __i386__
>>> #define SYS_translate_pid 386
>>> #endif
>>> #endif
>>>
>>> pid_t translate_pid(pid_t pid, int source, int target) {
>>> 	return syscall(SYS_translate_pid, pid, source, target);
>>> }
>>>
>>> int main(int argc, char **argv) {
>>> 	int pid, source, target;
>>> 	char buf[64];
>>>
>>> 	if (argc != 4)
>>> 		errx(1, "usage: %s <pid> <source> <target>", argv[0]);
>>>
>>> 	pid = atoi(argv[1]);
>>> 	source = atoi(argv[2]);
>>> 	target = atoi(argv[3]);
>>>
>>> 	if (source > 0) {
>>> 		snprintf(buf, sizeof(buf), "/proc/%d/ns/pid", source);
>>> 		source = open(buf, O_RDONLY);
>>> 		if (source < 0)
>>> 			err(2, "open source %s", buf);
>>> 	}
>>>
>>> 	if (target > 0) {
>>> 		snprintf(buf, sizeof(buf), "/proc/%d/ns/pid", target);
>>> 		target = open(buf, O_RDONLY);
>>> 		if (target < 0)
>>> 			err(2, "open target %s", buf);
>>> 	}
>>>
>>> 	pid = translate_pid(pid, source, target);
>>> 	if (pid < 0)
>>> 		err(2, "translate_pid");
>>>
>>> 	printf("%d\n", pid);
>>> 	return 0;
>>> }
>>>
>>> ---
>>> ---
>>>    arch/x86/entry/syscalls/syscall_32.tbl |    1
>>>    arch/x86/entry/syscalls/syscall_64.tbl |    1
>>>    include/linux/syscalls.h               |    1
>>>    kernel/pid_namespace.c                 |   66 ++++++++++++++++++++++++++++++++
>>>    kernel/sys_ni.c                        |    3 +
>>>    5 files changed, 72 insertions(+)
>>>
>>> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
>>> index 14a2f996e543..e70685750d43 100644
>>> --- a/arch/x86/entry/syscalls/syscall_32.tbl
>>> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
>>> @@ -397,3 +397,4 @@
>>>    383	i386	statx			sys_statx			__ia32_sys_statx
>>>    384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
>>>    385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
>>> +386	i386	translate_pid		sys_translate_pid		__ia32_sys_translate_pid
>>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>>> index cd36232ab62f..ebfd89055424 100644
>>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>>> @@ -342,6 +342,7 @@
>>>    331	common	pkey_free		__x64_sys_pkey_free
>>>    332	common	statx			__x64_sys_statx
>>>    333	common	io_pgetevents		__x64_sys_io_pgetevents
>>> +334	common	translate_pid		__x64_sys_translate_pid
>>>    
>>>    #
>>>    # x32-specific system call numbers start at 512 to avoid cache impact
>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>> index 390e814fdc8d..3f33971cf1c8 100644
>>> --- a/include/linux/syscalls.h
>>> +++ b/include/linux/syscalls.h
>>> @@ -843,6 +843,7 @@ asmlinkage long sys_clock_adjtime(clockid_t which_clock,
>>>    				struct timex __user *tx);
>>>    asmlinkage long sys_syncfs(int fd);
>>>    asmlinkage long sys_setns(int fd, int nstype);
>>> +asmlinkage long sys_translate_pid(pid_t pid, int source, int target);
>>>    asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
>>>    			     unsigned int vlen, unsigned flags);
>>>    asmlinkage long sys_process_vm_readv(pid_t pid,
>>> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
>>> index 2a2ac53d8b8b..3b872cbbe264 100644
>>> --- a/kernel/pid_namespace.c
>>> +++ b/kernel/pid_namespace.c
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/user_namespace.h>
>>>    #include <linux/syscalls.h>
>>>    #include <linux/cred.h>
>>> +#include <linux/file.h>
>>>    #include <linux/err.h>
>>>    #include <linux/acct.h>
>>>    #include <linux/slab.h>
>>> @@ -380,6 +381,71 @@ static void pidns_put(struct ns_common *ns)
>>>    	put_pid_ns(to_pid_ns(ns));
>>>    }
>>>    
>>> +static struct pid_namespace *get_pid_ns_by_fd(int fd)
>>> +{
>>> +	struct pid_namespace *pidns;
>>> +	struct ns_common *ns;
>>> +	struct file *file;
>>> +
>>> +	file = proc_ns_fget(fd);
>>> +	if (IS_ERR(file))
>>> +		return ERR_CAST(file);
>>> +
>>> +	ns = get_proc_ns(file_inode(file));
>>> +	if (ns->ops->type == CLONE_NEWPID)
>>> +		pidns = get_pid_ns(to_pid_ns(ns));
>>> +	else
>>> +		pidns = ERR_PTR(-EINVAL);
>>> +
>>> +	fput(file);
>>> +	return pidns;
>>> +}
>>> +
>>> +/*
>>> + * translate_pid - convert pid in source pid-ns into target pid-ns.
>>> + * @pid:    pid for translation
>>> + * @source: pid-ns file descriptor or -1 for active namespace
>>> + * @target: pid-ns file descriptor or -1 for active namesapce
>>> + *
>>> + * Returns pid in @target pid-ns, zero if task have no pid there,
>>> + * or -ESRCH if task with @pid does not found in @source pid-ns.
>>> + */
>>> +SYSCALL_DEFINE3(translate_pid, pid_t, pid, int, source, int, target)
>>> +{
>>> +	struct pid_namespace *source_ns, *target_ns;
>>> +	struct pid *struct_pid;
>>> +	pid_t result;
>>> +
>>> +	if (source >= 0) {
>>> +		source_ns = get_pid_ns_by_fd(source);
>>> +		result = PTR_ERR(source_ns);
>>> +		if (IS_ERR(source_ns))
>>> +			goto err_source;
>>> +	} else
>>> +		source_ns = task_active_pid_ns(current);
>>> +
>>> +	if (target >= 0) {
>>> +		target_ns = get_pid_ns_by_fd(target);
>>> +		result = PTR_ERR(target_ns);
>>> +		if (IS_ERR(target_ns))
>>> +			goto err_target;
>>> +	} else
>>> +		target_ns = task_active_pid_ns(current);
>>> +
>>> +	rcu_read_lock();
>>> +	struct_pid = find_pid_ns(pid, source_ns);
>>> +	result = struct_pid ? pid_nr_ns(struct_pid, target_ns) : -ESRCH;
>>> +	rcu_read_unlock();
>>> +
>>> +	if (target >= 0)
>>> +		put_pid_ns(target_ns);
>>> +err_target:
>>> +	if (source >= 0)
>>> +		put_pid_ns(source_ns);
>>> +err_source:
>>> +	return result;
>>> +}
>>> +
>>>    static int pidns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>>>    {
>>>    	struct pid_namespace *active = task_active_pid_ns(current);
>>> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>>> index 06b4ccee0047..bf276e9ace9a 100644
>>> --- a/kernel/sys_ni.c
>>> +++ b/kernel/sys_ni.c
>>> @@ -153,6 +153,9 @@ COND_SYSCALL_COMPAT(kexec_load);
>>>    COND_SYSCALL(init_module);
>>>    COND_SYSCALL(delete_module);
>>>    
>>> +/* kernel/pid_namespace.c */
>>> +COND_SYSCALL(translate_pid);
>>> +
>>>    /* kernel/posix-timers.c */
>>>    
>>>    /* kernel/printk.c */
>>>
>> Ping :-) Checking back again for Ack or comments.
> JFYI, I'll try to attract more attention to this proposal
> by mentioning it in my talk at the LPC 2018 as a potential solution
> for one of several problems we have in strace, see
> https://www.linuxplumbersconf.org/event/2/contributions/78/

The patch has been picked up by Eric and it is in his tree. Not sure why

it has not made to a linux release.

Thanks,

Nagarathnam.

>
